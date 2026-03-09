import 'package:intime_manager/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/models/response/login_response.dart';
import 'package:intime_manager/screens/field_main_screen.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/services/preference_service.dart';
import 'package:intime_manager/widgets/home/calendar_picker.dart';
import 'package:intime_manager/widgets/home/home_header.dart';
import 'package:intime_manager/widgets/home/field_list.dart';
import 'package:intime_manager/widgets/home/start_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  List<FieldItem> _fields = [];
  int? _selectedIndex;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  int _loadId = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String _formatWorkDate(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  bool _hasWorkIn(String value) => value.trim().isNotEmpty;

  Future<void> _loadData() async {
    final id = ++_loadId;
    final loginResponse = await PreferenceService.getLoginResponse();
    if (!mounted || id != _loadId) return;

    final base = _buildBaseFieldItems(loginResponse);
    setState(() {
      _fields = base;
      _isLoading = true;
      _selectedIndex = null;
    });

    await _fetchWorkerCounts(loginResponse, id);

    if (mounted && id == _loadId) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<FieldItem> _buildBaseFieldItems(LoginResponse? loginResponse) {
    if (loginResponse == null) return [];
    final items = <FieldItem>[];
    for (final corp in loginResponse.corporations) {
      for (final field in corp.fields) {
        items.add(FieldItem(
          companyID: corp.companyID,
          companyName: corp.companyName,
          fieldID: field.fieldID,
          fieldCode: field.fieldCode,
          fieldName: field.fieldName,
        ));
      }
    }
    return items;
  }

  Future<void> _fetchWorkerCounts(LoginResponse? loginResponse, int id) async {
    if (loginResponse == null) return;
    final workDate = _formatWorkDate(_selectedDate);

    await Future.wait(
      List.generate(_fields.length, (i) async {
        final field = _fields[i];
        try {
          final response = await _authService.getWorkInfo(
            companyID: field.companyID,
            fieldID: field.fieldID,
            fieldCode: field.fieldCode,
            workDate: workDate,
          );
          final list = response.empWorkingInfo;
          final workerIn =
              list.where((e) => _hasWorkIn(e.workIn)).length;
          final notOut = list
              .where((e) => _hasWorkIn(e.workIn) && !_hasWorkIn(e.workOut))
              .length;
          final unassigned =
              list.where((e) => e.deptID.trim().isEmpty).length;
          if (!mounted || id != _loadId) return;
          setState(() {
            _fields[i] = field.copyWith(
              workerCount: workerIn,
              notOut: notOut,
              unassigned: unassigned,
              empList: list,
            );
          });
        } catch (_) {}
      }),
    );
  }

  Future<void> _onDateTap() async {
    final picked = await showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => CalendarPicker(initialDate: _selectedDate),
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
      await _loadData();
    }
  }

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onStart() {
    if (_selectedIndex == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FieldMainScreen(
          fieldItem: _fields[_selectedIndex!],
          date: _selectedDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              date: _selectedDate,
              onDateTap: _onDateTap,
              onSettingsTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF00A63E),
                onRefresh: _loadData,
                child: FieldList(
                  fields: _fields,
                  selectedIndex: _selectedIndex,
                  onSelect: _onSelect,
                  isLoading: _isLoading,
                ),
              ),
            ),
            StartButton(
              onPressed: _selectedIndex != null ? _onStart : null,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

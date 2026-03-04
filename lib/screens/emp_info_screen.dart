import 'package:flutter/material.dart';
import 'package:intime_manager/models/emp_working_info.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/screens/dept_manage_screen.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/widgets/common/bottom_nav_bar.dart';
import 'package:intime_manager/widgets/field_main/field_main_header.dart';
import 'package:intime_manager/widgets/field_main/new_registrant_table.dart';
import 'package:intime_manager/widgets/home/calendar_picker.dart';

class EmpInfoScreen extends StatefulWidget {
  final FieldItem fieldItem;
  final DateTime date;

  const EmpInfoScreen({
    super.key,
    required this.fieldItem,
    required this.date,
  });

  @override
  State<EmpInfoScreen> createState() => _EmpInfoScreenState();
}

class _EmpInfoScreenState extends State<EmpInfoScreen> {
  final AuthService _authService = AuthService();

  late DateTime _selectedDate;
  late FieldItem _fieldItem;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
    _fieldItem = widget.fieldItem;
    _fetchData();
  }

  String _formatWorkDate(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  bool _hasValue(String value) => value.trim().isNotEmpty;

  List<EmpWorkingInfo> get _allEmps => _fieldItem.empList;

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);

    try {
      final response = await _authService.getWorkInfo(
        companyID: _fieldItem.companyID,
        fieldID: _fieldItem.fieldID,
        fieldCode: _fieldItem.fieldCode,
        workDate: _formatWorkDate(_selectedDate),
      );
      if (!mounted) return;

      final list = response.empWorkingInfo;
      final workerIn = list.where((e) => _hasValue(e.workIn)).length;
      final notOut = list
          .where((e) => _hasValue(e.workIn) && !_hasValue(e.workOut))
          .length;
      final unassigned = list.where((e) => e.deptID.trim().isEmpty).length;

      setState(() {
        _fieldItem = _fieldItem.copyWith(
          workerCount: workerIn,
          notOut: notOut,
          unassigned: unassigned,
          empList: list,
        );
      });
    } catch (_) {}

    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _onDateTap() async {
    final picked = await showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => CalendarPicker(initialDate: _selectedDate),
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
      await _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            FieldMainHeader(
              companyName: _fieldItem.companyName,
              fieldName: _fieldItem.fieldName,
              date: _selectedDate,
              onBack: () => Navigator.of(context).pop(),
              onDateTap: _onDateTap,
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00A63E),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                      child: NewRegistrantTable(
                        items: _allEmps,
                        fieldItem: _fieldItem,
                        title: '등록 직원 조회',
                        emptyMessage: '등록된 직원이 없습니다.',
                        onEmpDeleted: _fetchData,
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedTab: FieldTab.empInfo,
        onTap: (tab) {
          if (tab == FieldTab.home) {
            Navigator.of(context).pop();
          } else if (tab == FieldTab.fieldMain) {
            Navigator.of(context).pop();
          } else if (tab == FieldTab.deptManage) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => DeptManageScreen(
                  fieldItem: _fieldItem,
                  date: _selectedDate,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

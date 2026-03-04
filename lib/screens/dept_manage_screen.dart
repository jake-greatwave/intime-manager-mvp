import 'package:flutter/material.dart';
import 'package:intime_manager/models/dept.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/models/type_of_work.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/widgets/common/bottom_nav_bar.dart';
import 'package:intime_manager/widgets/dept_manage/dept_action_buttons.dart';
import 'package:intime_manager/widgets/dept_manage/dept_hint_card.dart';
import 'package:intime_manager/widgets/dept_manage/dept_section_title.dart';
import 'package:intime_manager/widgets/dept_manage/dept_table.dart';
import 'package:intime_manager/widgets/field_main/field_main_header.dart';

class DeptManageScreen extends StatefulWidget {
  final FieldItem fieldItem;
  final DateTime date;

  const DeptManageScreen({
    super.key,
    required this.fieldItem,
    required this.date,
  });

  @override
  State<DeptManageScreen> createState() => _DeptManageScreenState();
}

class _DeptManageScreenState extends State<DeptManageScreen> {
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  List<TypeOfWork> _typeOfWorks = [];
  List<Dept> _depts = [];
  int? _selectedIndex;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDepts();
  }

  Future<void> _fetchDepts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.getDeptInField(
        companyID: widget.fieldItem.companyID,
        fieldID: widget.fieldItem.fieldID,
      );
      if (!mounted) return;
      setState(() {
        _typeOfWorks = response.typeOfWork;
        _depts = response.deptInField;
        _selectedIndex = null;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '부서 목록을 불러오지 못했습니다.';
        _isLoading = false;
      });
    }
  }

  bool get _hasSelection => _selectedIndex != null;

  String get _hintMessage {
    if (_hasSelection) {
      return '선택된 부서: ${_depts[_selectedIndex!].deptName}';
    }
    return '수정하거나 삭제할 부서를 선택해주세요';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            FieldMainHeader(
              companyName: widget.fieldItem.companyName,
              fieldName: widget.fieldItem.fieldName,
              date: widget.date,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00A63E),
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A7282),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DeptSectionTitle(),
                              const SizedBox(height: 16),
                              DeptTable(
                                typeOfWorks: _typeOfWorks,
                                depts: _depts,
                                selectedIndex: _selectedIndex,
                                onRowTap: (i) => setState(() {
                                  _selectedIndex =
                                      _selectedIndex == i ? null : i;
                                }),
                              ),
                              const SizedBox(height: 16),
                              DeptHintCard(message: _hintMessage),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
            ),
            _DeptBottomArea(
              hasSelection: _hasSelection,
              onAdd: () {},
              onEdit: _hasSelection ? () {} : null,
              onDelete: _hasSelection ? () {} : null,
              onNavTap: (tab) {
                if (tab == FieldTab.home || tab == FieldTab.fieldMain) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DeptBottomArea extends StatelessWidget {
  final bool hasSelection;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final ValueChanged<FieldTab>? onNavTap;

  const _DeptBottomArea({
    required this.hasSelection,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF3F4F6), width: 1.4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DeptActionButtons(
            hasSelection: hasSelection,
            onAdd: onAdd,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
          const SizedBox(height: 12),
          BottomNavBar(
            selectedTab: FieldTab.deptManage,
            onTap: onNavTap,
          ),
        ],
      ),
    );
  }
}

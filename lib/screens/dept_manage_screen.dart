import 'package:intime_manager/screens/emp_info_screen.dart';
import 'package:intime_manager/widgets/emp_detail/delete_confirm_dialog.dart';
import 'package:intime_manager/screens/dept_add_screen.dart';
import 'package:intime_manager/screens/dept_edit_screen.dart';
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
  List<Dept> _depts = [];
  List<TypeOfWork> _typeOfWorks = [];
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
      debugPrint(
        '[DeptInField REQ] CompanyID=${widget.fieldItem.companyID} '
        'FieldID=${widget.fieldItem.fieldID}',
      );
      final response = await _authService.getDeptInField(
        companyID: widget.fieldItem.companyID,
        fieldID: widget.fieldItem.fieldID,
      );
      debugPrint(
        '[DeptInField RES] status=${response.status} '
        'message=${response.message} '
        'deptCount=${response.deptInField.length}',
      );
      if (!mounted) return;
      setState(() {
        _depts = response.deptInField;
        _typeOfWorks = response.typeOfWork;
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
              onAdd: () async {
                final added = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => DeptAddScreen(
                      fieldItem: widget.fieldItem,
                      typeOfWorkList: _typeOfWorks,
                    ),
                  ),
                );
                if (added == true) _fetchDepts();
              },
              onEdit: _hasSelection
                  ? () async {
                      final dept = _depts[_selectedIndex!];
                      final updated = await Navigator.of(context).push<bool>(
                        MaterialPageRoute(
                          builder: (_) => DeptEditScreen(
                            fieldItem: widget.fieldItem,
                            dept: dept,
                            typeOfWorkList: _typeOfWorks,
                          ),
                        ),
                      );
                      if (updated == true) _fetchDepts();
                    }
                  : null,
              onDelete: _hasSelection
                  ? () async {
                      final dept = _depts[_selectedIndex!];
                      final messenger = ScaffoldMessenger.of(context);
                      final confirmed = await showDialog<bool>(
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (_) => DeleteConfirmDialog(
                          title: '부서 삭제',
                          message:
                              '삭제한 부서는 되돌릴 수 없습니다.\n정말로 삭제하시겠습니까?',
                        ),
                      );
                      if (confirmed != true || !mounted) return;
                      try {
                        final response = await _authService.deleteDept(
                          companyID: widget.fieldItem.companyID,
                          fieldID: widget.fieldItem.fieldID,
                          deptID: dept.deptID,
                        );
                        if (!mounted) return;
                        if (response.status == 'SUCCESS') {
                          _fetchDepts();
                        } else {
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                response.message.isNotEmpty
                                    ? response.message
                                    : '삭제에 실패했습니다.',
                              ),
                              backgroundColor: const Color(0xFFEF4444),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              margin:
                                  const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            ),
                          );
                        }
                      } catch (_) {
                        if (!mounted) return;
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('네트워크 오류가 발생했습니다.'),
                            backgroundColor: Color(0xFFEF4444),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          ),
                        );
                      }
                    }
                  : null,
              onNavTap: (tab) {
                if (tab == FieldTab.home || tab == FieldTab.fieldMain) {
                  Navigator.of(context).pop();
                } else if (tab == FieldTab.empInfo) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => EmpInfoScreen(
                        fieldItem: widget.fieldItem,
                        date: widget.date,
                      ),
                    ),
                  );
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

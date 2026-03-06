import 'package:flutter/material.dart';
import 'package:intime_manager/models/dept.dart';
import 'package:intime_manager/models/emp_detail.dart';
import 'package:intime_manager/models/emp_working_info.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/widgets/emp_detail/delete_confirm_dialog.dart';
import 'package:intime_manager/widgets/emp_detail/dept_picker_sheet.dart';
import 'package:intime_manager/widgets/emp_detail/emp_avatar.dart';
import 'package:intime_manager/widgets/emp_detail/emp_info_form.dart';
import 'package:intime_manager/widgets/emp_detail/emp_field_info_card.dart';
import 'package:intime_manager/widgets/emp_detail/emp_action_buttons.dart';

class EmpDetailScreen extends StatefulWidget {
  final EmpWorkingInfo emp;
  final FieldItem fieldItem;

  const EmpDetailScreen({
    super.key,
    required this.emp,
    required this.fieldItem,
  });

  @override
  State<EmpDetailScreen> createState() => _EmpDetailScreenState();
}

class _EmpDetailScreenState extends State<EmpDetailScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  bool _isDeleting = false;
  EmpDetail? _empDetail;
  List<Dept> _deptList = [];
  int _selectedDeptID = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEmpInfo();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchEmpInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.getEmpInfo(
        companyID: widget.fieldItem.companyID,
        fieldID: widget.fieldItem.fieldID,
        enrollID: widget.emp.enrollID,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS' && response.empDetail != null) {
        final detail = response.empDetail!;
        _nameController.text = detail.empName.trim();
        setState(() {
          _empDetail = detail;
          _deptList = response.deptInField;
          _selectedDeptID = detail.deptID;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message.isNotEmpty
              ? response.message
              : '데이터를 불러오지 못했습니다.';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '네트워크 오류가 발생했습니다.';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateEmpInfo() async {
    if (_isSaving || _empDetail == null) return;

    final newName = _nameController.text.trim();
    if (newName.isEmpty) {
      _showSnackBar('이름을 입력해주세요.', isError: true);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final updated = _empDetail!.copyWith(
        empName: newName,
        deptID: _selectedDeptID,
      );

      final response = await _authService.updateEmpInfo(empDetail: updated);

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        setState(() {
          _empDetail = updated;
          _selectedDeptID = updated.deptID;
        });
        _showSnackBar('수정이 완료되었습니다.');
        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) Navigator.of(context).pop(true);
      } else {
        _showSnackBar(
          response.message.isNotEmpty ? response.message : '수정에 실패했습니다.',
          isError: true,
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('네트워크 오류가 발생했습니다.', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color(0xFFEF4444) : const Color(0xFF00A63E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }

  String _nameChar() {
    final text = _nameController.text.trim();
    final name = text.isNotEmpty ? text : (_empDetail?.empName ?? widget.emp.empName).trim();
    if (name.isEmpty) return '?';
    return name.characters.first;
  }

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '-';
    final datePart = dateStr.split(' ').first;
    final parts = datePart.split('-');
    if (parts.length < 3) return datePart;
    return '${parts[0].substring(2)}-${parts[1]}-${parts[2]}';
  }

  String _deptNameById(int deptID) {
    if (deptID == 0) return '미배정';
    final found = _deptList.where((d) => d.deptID == deptID).toList();
    if (found.isNotEmpty) return found.first.deptName;
    return widget.emp.deptName.isEmpty ? '미배정' : widget.emp.deptName;
  }

  Future<void> _onDeptTap() async {
    List<Dept> listToShow = _deptList;

    if (listToShow.isEmpty) {
      try {
        final response = await _authService.getDeptInField(
          companyID: widget.fieldItem.companyID,
          fieldID: widget.fieldItem.fieldID,
        );
        if (!mounted) return;
        if (response.status == 'SUCCESS') {
          listToShow = response.deptInField;
          setState(() => _deptList = listToShow);
        }
      } catch (_) {}
    }

    if (!mounted) return;

    final picked = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeptPickerSheet(
        deptList: listToShow,
        currentDeptID: _selectedDeptID,
      ),
    );

    if (picked != null && mounted) {
      setState(() => _selectedDeptID = picked);
    }
  }

  Future<void> _deleteEmp() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => const DeleteConfirmDialog(),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);

    try {
      debugPrint(
        '[QuitEmp REQ] CompanyID=${widget.fieldItem.companyID} '
        'FieldID=${widget.fieldItem.fieldID} '
        'EnrollID=${widget.emp.enrollID}',
      );

      final response = await _authService.quitEmp(
        companyID: widget.fieldItem.companyID,
        fieldID: widget.fieldItem.fieldID,
        enrollID: widget.emp.enrollID,
      );

      debugPrint(
        '[QuitEmp RES] status=${response.status} message=${response.message}',
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        Navigator.of(context).pop(true);
      } else {
        _showSnackBar(
          response.message.isNotEmpty ? response.message : '삭제에 실패했습니다.',
          isError: true,
        );
        setState(() => _isDeleting = false);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('네트워크 오류가 발생했습니다.', isError: true);
      setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _EmpDetailHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00A63E),
                      ),
                    )
                  : _errorMessage != null
                      ? _ErrorView(
                          message: _errorMessage!,
                          onRetry: _fetchEmpInfo,
                        )
                      : _buildContent(),
            ),
            if (!_isLoading && _errorMessage == null)
              EmpActionButtons(
                onSave: _isSaving ? null : _updateEmpInfo,
                onDelete: (_isSaving || _isDeleting) ? null : _deleteEmp,
                isSaving: _isSaving,
                isDeleting: _isDeleting,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final detail = _empDetail!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        children: [
          Center(child: EmpAvatar(
            nameChar: _nameChar(),
            base64Image: detail.base64StringImage,
          )),
          const SizedBox(height: 24),
          EmpInfoForm(
            enrollID: detail.phoneNum.isNotEmpty
                ? detail.phoneNum
                : detail.enrollID,
            empName: detail.empName.trim().isEmpty ? '-' : detail.empName.trim(),
            deptName: _deptNameById(_selectedDeptID),
            lastAuthLog: _formatDate(widget.emp.lastAuthLog),
            nameController: _nameController,
            onDeptTap: _onDeptTap,
          ),
          const SizedBox(height: 24),
          EmpFieldInfoCard(
            companyName: widget.fieldItem.companyName,
            fieldName: widget.fieldItem.fieldName,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _EmpDetailHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const _EmpDetailHeader({this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.chevron_left,
                color: Color(0xFF101828),
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '직원 정보',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF101828),
              letterSpacing: 0.07,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6A7282),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A63E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '다시 시도',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

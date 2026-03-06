import 'package:flutter/material.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/models/type_of_work.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/widgets/dept_manage/type_of_work_picker_sheet.dart';

class DeptAddScreen extends StatefulWidget {
  final FieldItem fieldItem;
  final List<TypeOfWork> typeOfWorkList;

  const DeptAddScreen({
    super.key,
    required this.fieldItem,
    required this.typeOfWorkList,
  });

  @override
  State<DeptAddScreen> createState() => _DeptAddScreenState();
}

class _DeptAddScreenState extends State<DeptAddScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();

  int? _selectedTypeOfWorkID;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _selectedTypeOfWorkName {
    if (_selectedTypeOfWorkID == null) return '공종을 선택해주세요';
    final found = widget.typeOfWorkList
        .where((t) => t.typeOfWorkID == _selectedTypeOfWorkID)
        .toList();
    return found.isNotEmpty ? found.first.typeOfWorkName : '-';
  }

  Future<void> _onTypeOfWorkTap() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TypeOfWorkPickerSheet(
        typeOfWorkList: widget.typeOfWorkList,
        currentTypeOfWorkID: _selectedTypeOfWorkID ?? 0,
      ),
    );
    if (picked != null && mounted) {
      setState(() => _selectedTypeOfWorkID = picked);
    }
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (_selectedTypeOfWorkID == null) {
      _showSnackBar('공종을 선택해주세요.', isError: true);
      return;
    }
    if (name.isEmpty) {
      _showSnackBar('부서명을 입력해주세요.', isError: true);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final response = await _authService.addDept(
        companyID: widget.fieldItem.companyID,
        fieldID: widget.fieldItem.fieldID,
        deptName: name,
        typeOfWorkID: _selectedTypeOfWorkID!,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        _showSnackBar('부서가 추가되었습니다.');
        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) Navigator.of(context).pop(true);
      } else {
        _showSnackBar(
          response.message.isNotEmpty ? response.message : '추가에 실패했습니다.',
          isError: true,
        );
      }
    } catch (_) {
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
            _DeptAddHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LabeledField(
                      label: '공종',
                      value: _selectedTypeOfWorkName,
                      hasSelection: _selectedTypeOfWorkID != null,
                      isDropdown: true,
                      onTap: _onTypeOfWorkTap,
                    ),
                    const SizedBox(height: 20),
                    _LabeledField(
                      label: '부서명',
                      controller: _nameController,
                    ),
                  ],
                ),
              ),
            ),
            _SaveButton(isSaving: _isSaving, onSave: _save),
          ],
        ),
      ),
    );
  }
}

class _DeptAddHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const _DeptAddHeader({this.onBack});

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
              child: Icon(Icons.chevron_left,
                  color: Color(0xFF101828), size: 28),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '부서 추가',
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

class _LabeledField extends StatelessWidget {
  final String label;
  final String? value;
  final TextEditingController? controller;
  final bool isDropdown;
  final bool hasSelection;
  final VoidCallback? onTap;

  const _LabeledField({
    required this.label,
    this.value,
    this.controller,
    this.isDropdown = false,
    this.hasSelection = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A7282),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 8),
        isDropdown
            ? GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value ?? '-',
                          style: TextStyle(
                            fontSize: 16,
                            color: hasSelection
                                ? const Color(0xFF1E2939)
                                : const Color(0xFF99A1AF),
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF6A7282), size: 22),
                    ],
                  ),
                ),
              )
            : TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFF00A63E), width: 1.5),
                  ),
                ),
                style: const TextStyle(
                    fontSize: 16, color: Color(0xFF1E2939)),
              ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isSaving;
  final VoidCallback? onSave;

  const _SaveButton({required this.isSaving, this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF3F4F6), width: 1.4),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      child: GestureDetector(
        onTap: isSaving ? null : onSave,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF00A63E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isSaving
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : const Text(
                    '추가 완료',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

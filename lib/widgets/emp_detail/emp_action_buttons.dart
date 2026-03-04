import 'package:flutter/material.dart';

class EmpActionButtons extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onDelete;
  final bool isSaving;
  final bool isDeleting;

  const EmpActionButtons({
    super.key,
    this.onSave,
    this.onDelete,
    this.isSaving = false,
    this.isDeleting = false,
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
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SaveButton(onTap: onSave, isSaving: isSaving),
          const SizedBox(height: 12),
          _DeleteButton(onTap: onDelete, isDeleting: isDeleting),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSaving;

  const _SaveButton({this.onTap, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 64,
        decoration: BoxDecoration(
          color: isSaving
              ? const Color(0xFF00A63E).withValues(alpha: 0.7)
              : const Color(0xFF00A63E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isSaving
              ? const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_alt, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text(
                      '수정 완료',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.07,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isDeleting;

  const _DeleteButton({this.onTap, required this.isDeleting});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDeleting
                ? const Color(0xFFEF4444).withValues(alpha: 0.4)
                : const Color(0xFFEF4444),
            width: 2,
          ),
        ),
        child: Center(
          child: isDeleting
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Color(0xFFEF4444),
                    strokeWidth: 2.5,
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
                    SizedBox(width: 12),
                    Text(
                      '직원 삭제',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEF4444),
                        letterSpacing: 0.07,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

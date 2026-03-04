import 'package:flutter/material.dart';

class DeptActionButtons extends StatelessWidget {
  final bool hasSelection;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DeptActionButtons({
    super.key,
    required this.hasSelection,
    this.onAdd,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.add,
          label: '부서추가',
          isActive: true,
          onTap: onAdd,
        ),
        const SizedBox(width: 12),
        _ActionButton(
          icon: Icons.edit_outlined,
          label: '부서수정',
          isActive: hasSelection,
          onTap: hasSelection ? onEdit : null,
        ),
        const SizedBox(width: 12),
        _ActionButton(
          icon: Icons.delete_outline,
          label: '부서삭제',
          isActive: hasSelection,
          onTap: hasSelection ? onDelete : null,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isActive ? const Color(0xFF00A63E) : const Color(0xFFE5E7EB);
    final fg = isActive ? Colors.white : const Color(0xFF9CA3AF);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: fg,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

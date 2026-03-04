import 'package:flutter/material.dart';

class DeptTableRow extends StatelessWidget {
  final String typeOfWork;
  final String deptName;
  final bool isEven;
  final bool isSelected;
  final VoidCallback? onTap;

  const DeptTableRow({
    super.key,
    required this.typeOfWork,
    required this.deptName,
    required this.isEven,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    if (isSelected) {
      bg = const Color(0xFF00A63E).withValues(alpha: 0.15);
    } else {
      bg = isEven ? const Color(0xFFF0FDF4) : Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 57,
        decoration: BoxDecoration(
          color: bg,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFF3F4F6), width: 0.7),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: Text(
                typeOfWork,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected
                      ? const Color(0xFF00A63E)
                      : const Color(0xFF1E2939),
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Expanded(
              child: Text(
                deptName,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected
                      ? const Color(0xFF00A63E)
                      : const Color(0xFF1E2939),
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF00A63E),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}

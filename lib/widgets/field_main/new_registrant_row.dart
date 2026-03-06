import 'package:flutter/material.dart';

class NewRegistrantRow extends StatelessWidget {
  final String enrollID;
  final String deptName;
  final String lastAuthLog;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const NewRegistrantRow({
    super.key,
    required this.enrollID,
    required this.deptName,
    required this.lastAuthLog,
    this.isHighlighted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isHighlighted ? const Color(0xFF00A63E) : Colors.white;
    final idColor = isHighlighted ? Colors.white : const Color(0xFF1E2939);
    final subColor = isHighlighted ? Colors.white : const Color(0xFF6A7282);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFF3F4F6), width: 0.6),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            SizedBox(
              width: 146,
              child: Text(
                enrollID,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: idColor,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            SizedBox(
              width: 88,
              child: Text(
                deptName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: subColor,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Expanded(
              child: Text(
                lastAuthLog,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: subColor,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

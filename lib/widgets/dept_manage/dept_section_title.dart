import 'package:flutter/material.dart';

class DeptSectionTitle extends StatelessWidget {
  const DeptSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF00A63E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.table_chart_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          '부서 관리',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF101828),
            letterSpacing: 0.07,
          ),
        ),
      ],
    );
  }
}

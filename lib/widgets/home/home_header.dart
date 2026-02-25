import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final DateTime date;
  final VoidCallback? onDateTap;

  const HomeHeader({super.key, required this.date, this.onDateTap});

  String _weekdayLabel() {
    const labels = ['월', '화', '수', '목', '금', '토', '일'];
    return labels[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '현장 선택',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF99A1AF),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onDateTap,
            behavior: HitTestBehavior.opaque,
            child: Text(
              '${date.year}년 ${date.month}월 ${date.day}일\n(${_weekdayLabel()}요일)',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF101828),
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

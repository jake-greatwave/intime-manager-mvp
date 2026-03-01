import 'package:flutter/material.dart';

class FieldMainHeader extends StatelessWidget {
  final String companyName;
  final String fieldName;
  final DateTime date;
  final VoidCallback? onBack;
  final VoidCallback? onDateTap;

  const FieldMainHeader({
    super.key,
    required this.companyName,
    required this.fieldName,
    required this.date,
    this.onBack,
    this.onDateTap,
  });

  String _dateLabel() {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final wd = weekdays[date.weekday - 1];
    return '${date.year}년 ${date.month}월 ${date.day}일 ($wd요일)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.7),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              GestureDetector(
                onTap: onDateTap,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Color(0xFF00A63E),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _dateLabel(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF101828),
                        letterSpacing: -0.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00A63E).withValues(alpha: 0.2),
                width: 1.7,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E2939),
                    letterSpacing: 0.07,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fieldName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A63E),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

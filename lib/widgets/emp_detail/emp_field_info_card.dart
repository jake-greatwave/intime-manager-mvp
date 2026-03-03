import 'package:flutter/material.dart';

class EmpFieldInfoCard extends StatelessWidget {
  final String companyName;
  final String fieldName;

  const EmpFieldInfoCard({
    super.key,
    required this.companyName,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00A63E).withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '소속 현장',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF99A1AF),
              letterSpacing: -0.3125,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            companyName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E2939),
              letterSpacing: 0.07,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fieldName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A63E),
              letterSpacing: -0.3125,
            ),
          ),
        ],
      ),
    );
  }
}

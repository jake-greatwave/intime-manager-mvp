import 'package:flutter/material.dart';

class TermsSectionHeader extends StatelessWidget {
  const TermsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF4CAF50),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '서비스 이용 약관',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

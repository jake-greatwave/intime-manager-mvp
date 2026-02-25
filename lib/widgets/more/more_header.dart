import 'package:flutter/material.dart';

class MoreHeader extends StatelessWidget {
  const MoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: const Text(
        '내 정보',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Color(0xFF101828),
          letterSpacing: -1.1,
        ),
      ),
    );
  }
}

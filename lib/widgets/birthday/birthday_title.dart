import 'package:flutter/material.dart';

class BirthdayTitle extends StatelessWidget {
  const BirthdayTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(
            text: '생년월일 8자리를',
            style: TextStyle(color: Color(0xFF4CAF50)),
          ),
          TextSpan(text: ' 입력해 주세요.'),
        ],
      ),
    );
  }
}

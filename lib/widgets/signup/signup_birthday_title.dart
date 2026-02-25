import 'package:flutter/material.dart';

class SignupBirthdayTitle extends StatelessWidget {
  const SignupBirthdayTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              letterSpacing: -0.5,
            ),
            children: [
              TextSpan(text: '생년월일 '),
              TextSpan(
                text: '8자리를',
                style: TextStyle(color: Color(0xFF4CAF50)),
              ),
              TextSpan(text: '\n입력해 주세요.'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '추후 본인 확인을 위해 사용됩니다.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

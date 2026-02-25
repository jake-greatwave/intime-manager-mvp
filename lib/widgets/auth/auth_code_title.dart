import 'package:flutter/material.dart';

class AuthCodeTitle extends StatelessWidget {
  const AuthCodeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
          letterSpacing: -0.5,
          height: 1.4,
        ),
        children: [
          TextSpan(text: '문자로 받은\n'),
          TextSpan(
            text: '인증번호 4자리를',
            style: TextStyle(color: Color(0xFF00C637)),
          ),
          TextSpan(text: '\n입력해주세요.'),
        ],
      ),
    );
  }
}

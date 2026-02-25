import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainTitle(),
        const SizedBox(height: 8),
        _buildSubtitle(),
      ],
    );
  }

  Widget _buildMainTitle() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(text: '본인 확인을 위해 '),
          TextSpan(
            text: '휴대폰 번호',
            style: TextStyle(color: Color(0xFF4CAF50)),
          ),
          TextSpan(text: '를 입력해주세요.'),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      '숫자만 입력해 주세요.',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
        letterSpacing: -0.3,
      ),
    );
  }
}

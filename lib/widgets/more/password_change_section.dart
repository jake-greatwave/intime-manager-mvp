import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/more/password_input_field.dart';
import 'package:intime_manager/widgets/more/save_button.dart';

class PasswordChangeSection extends StatelessWidget {
  const PasswordChangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lock_outline,
                color: Color(0xFF00A63E),
                size: 30,
              ),
              const SizedBox(width: 10),
              const Text(
                '비밀번호 변경',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF101828),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const PasswordInputField(
            label: '이전 암호',
            hint: '현재 8자리 입력',
          ),
          const SizedBox(height: 16),
          const PasswordInputField(
            label: '암호변경 (생년월일 권장)',
            hint: '새로운 8자리 입력',
          ),
          const SizedBox(height: 16),
          const PasswordInputField(
            label: '암호확인',
            hint: '한 번 더 입력',
          ),
          const SizedBox(height: 24),
          SaveButton(onPressed: () {}),
        ],
      ),
    );
  }
}

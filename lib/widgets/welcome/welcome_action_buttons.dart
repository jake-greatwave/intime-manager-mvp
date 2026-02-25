import 'package:flutter/material.dart';

class WelcomeActionButtons extends StatelessWidget {
  final int currentPage;
  final bool skipWelcome;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final ValueChanged<bool> onSkipWelcomeChanged;

  const WelcomeActionButtons({
    super.key,
    required this.currentPage,
    required this.skipWelcome,
    required this.onNext,
    required this.onSkip,
    required this.onSkipWelcomeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          if (currentPage == 2) _buildSkipWelcomeCheckbox(),
          if (currentPage == 2) const SizedBox(height: 24),
          _buildPrimaryButton(),
          const SizedBox(height: 16),
          _buildSkipButton(),
        ],
      ),
    );
  }

  Widget _buildSkipWelcomeCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: skipWelcome,
          onChanged: (value) => onSkipWelcomeChanged(value ?? false),
          activeColor: const Color(0xFF4CAF50),
        ),
        const Text(
          '다시 보지 않음',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          currentPage == 2 ? '시작하기' : '다음으로',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: onSkip,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF666666),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: const Text(
        '건너뛰기',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

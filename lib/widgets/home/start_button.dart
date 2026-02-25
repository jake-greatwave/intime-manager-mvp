import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const StartButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A63E),
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFFE0E0E0),
            disabledForegroundColor: const Color(0xFF999999),
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            '현장 관리 시작',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.07,
            ),
          ),
        ),
      ),
    );
  }
}

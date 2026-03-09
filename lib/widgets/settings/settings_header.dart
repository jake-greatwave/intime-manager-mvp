import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const SettingsHeader({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.chevron_left,
                color: Color(0xFF101828),
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '설정',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF101828),
              letterSpacing: 0.07,
            ),
          ),
        ],
      ),
    );
  }
}

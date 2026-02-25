import 'package:flutter/material.dart';
import 'package:intime_manager/config/app_version.dart';
import 'package:intime_manager/widgets/more/app_info_row.dart';
import 'package:intime_manager/widgets/more/logout_button.dart';

class AppInfoSection extends StatelessWidget {
  final VoidCallback? onLogout;

  const AppInfoSection({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 28, bottom: 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFF9FAFB), width: 3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: Color(0xFF99A1AF),
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  '프로그램 정보',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF99A1AF),
                    letterSpacing: 2.4,
                  ),
                ),
              ],
            ),
          ),
          const AppInfoRow(label: '제작사', value: '엔트롤(주)'),
          const SizedBox(height: 8),
          const AppInfoRow(
            label: '버전',
            value: AppVersion.version,
            valueColor: Color(0xFF00A63E),
          ),
          const SizedBox(height: 28),
          LogoutButton(onPressed: onLogout),
        ],
      ),
    );
  }
}

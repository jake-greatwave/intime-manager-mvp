import 'package:flutter/material.dart';
import 'package:intime_manager/config/app_version.dart';
import 'package:intime_manager/services/preference_service.dart';
import 'package:intime_manager/widgets/settings/app_info_section.dart';
import 'package:intime_manager/widgets/settings/logout_button.dart';
import 'package:intime_manager/widgets/settings/settings_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => _LogoutConfirmDialog(),
    );
    if (confirmed != true) return;

    await PreferenceService.clearLoginResponse();

    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppInfoSection(version: AppVersion.version),
                    LogoutButton(onTap: () => _logout(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFE7000B).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout,
                color: Color(0xFFE7000B),
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '로그아웃',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF101828),
                letterSpacing: 0.07,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '로그아웃 하시겠습니까?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6A7282),
                height: 1.6,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    label: '취소',
                    onTap: () => Navigator.of(context).pop(false),
                    isDestructive: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogButton(
                    label: '로그아웃',
                    onTap: () => Navigator.of(context).pop(true),
                    isDestructive: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DialogButton({
    required this.label,
    required this.onTap,
    required this.isDestructive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDestructive ? const Color(0xFFE7000B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDestructive
                ? const Color(0xFFE7000B)
                : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color:
                  isDestructive ? Colors.white : const Color(0xFF6A7282),
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}

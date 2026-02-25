import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/more/app_info_section.dart';
import 'package:intime_manager/widgets/more/more_header.dart';
import 'package:intime_manager/widgets/more/password_change_section.dart';
import 'package:intime_manager/widgets/more/user_info_section.dart';

class MoreScreen extends StatelessWidget {
  final String enrollNumber;
  final String name;

  const MoreScreen({
    super.key,
    this.enrollNumber = '-',
    this.name = '-',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            const MoreHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserInfoSection(
                      enrollNumber: enrollNumber,
                      name: name,
                    ),
                    const SizedBox(height: 8),
                    const PasswordChangeSection(),
                    const SizedBox(height: 8),
                    AppInfoSection(
                      onLogout: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        selectedIndex: 2,
        onTap: (index) {
          if (index != 2) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const _BottomNav({
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.dashboard_outlined,
            label: '대시보드',
            isSelected: selectedIndex == 0,
            onTap: () => onTap?.call(0),
          ),
          _NavItem(
            icon: Icons.people_outline,
            label: '직원관리',
            isSelected: selectedIndex == 1,
            onTap: () => onTap?.call(1),
          ),
          _NavItem(
            icon: Icons.more_horiz,
            label: '더보기',
            isSelected: selectedIndex == 2,
            onTap: () => onTap?.call(2),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFFFDC700) : const Color(0xFF99A1AF);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

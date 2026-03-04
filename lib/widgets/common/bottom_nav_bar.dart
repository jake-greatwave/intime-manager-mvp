import 'package:flutter/material.dart';

enum FieldTab { home, fieldMain, deptManage, empInfo }

class BottomNavBar extends StatelessWidget {
  final FieldTab selectedTab;
  final ValueChanged<FieldTab>? onTap;

  const BottomNavBar({
    super.key,
    required this.selectedTab,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFF3F4F6), width: 1.7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.arrow_back_ios_new,
                label: '첫화면',
                isSelected: false,
                isDisabled: false,
                onTap: () => onTap?.call(FieldTab.home),
              ),
              _NavItem(
                icon: Icons.people,
                label: '현장메인',
                isSelected: selectedTab == FieldTab.fieldMain,
                isDisabled: false,
                onTap: () => onTap?.call(FieldTab.fieldMain),
              ),
              _NavItem(
                icon: Icons.people,
                label: '부서관리',
                isSelected: selectedTab == FieldTab.deptManage,
                isDisabled: false,
                onTap: () => onTap?.call(FieldTab.deptManage),
              ),
              _NavItem(
                icon: Icons.people,
                label: '직원정보',
                isSelected: selectedTab == FieldTab.empInfo,
                isDisabled: true,
                onTap: () => onTap?.call(FieldTab.empInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconBg =
        isSelected ? const Color(0xFF00A63E) : const Color(0xFF99A1AF);
    final labelColor =
        isSelected ? const Color(0xFF00A63E) : const Color(0xFF6A7282);

    return Expanded(
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1.0,
        child: GestureDetector(
          onTap: isDisabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 92,
            decoration: isSelected
                ? BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    border: Border.all(
                      color: const Color(0xFF00A63E).withValues(alpha: 0.3),
                      width: 1.7,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  )
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

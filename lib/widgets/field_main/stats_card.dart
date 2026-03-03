import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.count,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 147,
          decoration: BoxDecoration(
            color: isSelected
                ? iconColor.withValues(alpha: 0.08)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? iconColor : const Color(0xFFF3F4F6),
              width: isSelected ? 2.5 : 2.9,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? iconColor : const Color(0xFF99A1AF),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: isSelected ? iconColor : const Color(0xFF101828),
                  letterSpacing: 0.37,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

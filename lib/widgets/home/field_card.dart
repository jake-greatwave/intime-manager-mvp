import 'package:flutter/material.dart';

class FieldCard extends StatelessWidget {
  final String companyName;
  final String fieldName;
  final int workerCount;
  final bool isSelected;
  final VoidCallback onTap;

  const FieldCard({
    super.key,
    required this.companyName,
    required this.fieldName,
    required this.workerCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isSelected ? const Color(0xFF00A63E) : const Color(0xFFF3F4F6);
    final iconBgColor =
        isSelected ? const Color(0xFF00A63E) : const Color(0xFFF0FDF4);
    final iconColor =
        isSelected ? Colors.white : const Color(0xFF00A63E);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(26, 26, 26, 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _FieldIcon(bgColor: iconBgColor, iconColor: iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: _FieldInfo(
                companyName: companyName,
                fieldName: fieldName,
              ),
            ),
            _WorkerCount(count: workerCount),
          ],
        ),
      ),
    );
  }
}

class _FieldIcon extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;

  const _FieldIcon({required this.bgColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.location_on,
        color: iconColor,
        size: 24,
      ),
    );
  }
}

class _FieldInfo extends StatelessWidget {
  final String companyName;
  final String fieldName;

  const _FieldInfo({
    required this.companyName,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          companyName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E2939),
            letterSpacing: 0.07,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fieldName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF99A1AF),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

class _WorkerCount extends StatelessWidget {
  final int count;

  const _WorkerCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Color(0xFF00A63E),
            letterSpacing: 0.37,
            height: 1.1,
          ),
        ),
        const Text(
          '명',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF99A1AF),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

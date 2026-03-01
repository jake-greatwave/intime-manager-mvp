import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/field_main/stats_card.dart';

class StatsRow extends StatelessWidget {
  final int workerIn;
  final int notOut;
  final int unassigned;

  const StatsRow({
    super.key,
    required this.workerIn,
    required this.notOut,
    required this.unassigned,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatsCard(
          iconColor: const Color(0xFF00A63E),
          icon: Icons.login,
          label: '출근인원',
          count: workerIn,
        ),
        const SizedBox(width: 12),
        StatsCard(
          iconColor: const Color(0xFFF59E0B),
          icon: Icons.hourglass_bottom,
          label: '미퇴근',
          count: notOut,
        ),
        const SizedBox(width: 12),
        StatsCard(
          iconColor: const Color(0xFFEF4444),
          icon: Icons.person_off,
          label: '미배정',
          count: unassigned,
        ),
      ],
    );
  }
}

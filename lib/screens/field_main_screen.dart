import 'package:flutter/material.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/widgets/common/bottom_nav_bar.dart';
import 'package:intime_manager/widgets/field_main/field_main_header.dart';
import 'package:intime_manager/widgets/field_main/stats_row.dart';
import 'package:intime_manager/widgets/field_main/new_registrant_table.dart';

class FieldMainScreen extends StatelessWidget {
  final FieldItem fieldItem;
  final DateTime date;

  const FieldMainScreen({
    super.key,
    required this.fieldItem,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            FieldMainHeader(
              companyName: fieldItem.companyName,
              fieldName: fieldItem.fieldName,
              date: date,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  children: [
                    StatsRow(
                      workerIn: fieldItem.workerCount,
                      notOut: fieldItem.notOut,
                      unassigned: fieldItem.unassigned,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: NewRegistrantTable(items: fieldItem.empList),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedTab: FieldTab.fieldMain,
        onTap: (tab) {
          if (tab == FieldTab.home) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

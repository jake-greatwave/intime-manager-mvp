import 'package:flutter/material.dart';
import 'package:intime_manager/models/field_item.dart';
import 'package:intime_manager/widgets/home/field_card.dart';

class FieldList extends StatelessWidget {
  final List<FieldItem> fields;
  final int? selectedIndex;
  final void Function(int index) onSelect;
  final bool isLoading;

  const FieldList({
    super.key,
    required this.fields,
    required this.selectedIndex,
    required this.onSelect,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty && !isLoading) {
      return const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: 300,
          child: Center(
            child: Text(
              '현장 정보가 없습니다.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF99A1AF),
              ),
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      itemCount: fields.length + (isLoading ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == fields.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: CircularProgressIndicator(
                color: Color(0xFF00A63E),
                strokeWidth: 2,
              ),
            ),
          );
        }
        final field = fields[index];
        return FieldCard(
          companyName: field.companyName,
          fieldName: field.fieldName,
          workerCount: field.workerCount,
          isSelected: selectedIndex == index,
          onTap: () => onSelect(index),
        );
      },
    );
  }
}

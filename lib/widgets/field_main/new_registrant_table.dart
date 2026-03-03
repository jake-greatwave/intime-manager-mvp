import 'package:flutter/material.dart';
import 'package:intime_manager/models/emp_working_info.dart';
import 'package:intime_manager/widgets/field_main/new_registrant_row.dart';

class NewRegistrantTable extends StatelessWidget {
  final List<EmpWorkingInfo> items;
  final String title;
  final String emptyMessage;

  const NewRegistrantTable({
    super.key,
    required this.items,
    this.title = '신규 등록자',
    this.emptyMessage = '데이터가 없습니다.',
  });

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '-';
    final datePart = dateStr.split(' ').first;
    final parts = datePart.split('-');
    if (parts.length < 3) return datePart;
    return '${parts[0].substring(2)}-${parts[1]}-${parts[2]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 2.9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _TableHeader(title: title, count: items.length),
          _ColumnHeader(),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      emptyMessage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF99A1AF),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return NewRegistrantRow(
                        enrollID: item.enrollID,
                        deptName:
                            item.deptName.isEmpty ? '미배정' : item.deptName,
                        lastAuthLog: _formatDate(item.lastAuthLog),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String title;
  final int count;

  const _TableHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      color: const Color(0xFF00A63E),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.07,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count명',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  const _ColumnHeader();

  static const _style = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFF6A7282),
    letterSpacing: -0.3,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.7),
        ),
      ),
      child: Row(
        children: const [
          SizedBox(width: 16),
          SizedBox(width: 146, child: Text('ID', style: _style)),
          SizedBox(
            width: 88,
            child: Text('부서', textAlign: TextAlign.center, style: _style),
          ),
          Expanded(
            child: Text(
              '최근기록',
              textAlign: TextAlign.right,
              style: _style,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

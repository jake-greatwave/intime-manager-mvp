import 'package:flutter/material.dart';
import 'package:intime_manager/models/dept.dart';
import 'package:intime_manager/widgets/dept_manage/dept_table_row.dart';

class DeptTable extends StatelessWidget {
  final List<Dept> depts;
  final int? selectedIndex;
  final ValueChanged<int>? onRowTap;

  const DeptTable({
    super.key,
    required this.depts,
    this.selectedIndex,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 2.7),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DeptColumnHeader(),
          if (depts.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  '등록된 부서가 없습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF99A1AF),
                  ),
                ),
              ),
            )
          else
            ...List.generate(depts.length, (i) {
              final dept = depts[i];
              return DeptTableRow(
                typeOfWork: dept.typeOfWorkName.isNotEmpty
                    ? dept.typeOfWorkName
                    : '-',
                deptName: dept.deptName,
                isEven: i.isEven,
                isSelected: selectedIndex == i,
                onTap: () => onRowTap?.call(i),
              );
            }),
        ],
      ),
    );
  }
}

class _DeptColumnHeader extends StatelessWidget {
  const _DeptColumnHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          SizedBox(
            width: 160,
            child: Text(
              '공종',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A7282),
                letterSpacing: -0.3125,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '부서명',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A7282),
                letterSpacing: -0.3125,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intime_manager/models/dept.dart';

class DeptPickerSheet extends StatefulWidget {
  final List<Dept> deptList;
  final int currentDeptID;

  const DeptPickerSheet({
    super.key,
    required this.deptList,
    required this.currentDeptID,
  });

  @override
  State<DeptPickerSheet> createState() => _DeptPickerSheetState();
}

class _DeptPickerSheetState extends State<DeptPickerSheet> {
  late int _selectedID;

  @override
  void initState() {
    super.initState();
    _selectedID = widget.currentDeptID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetHandle(),
          _SheetHeader(),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: widget.deptList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: Text(
                        '부서 정보가 없습니다.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF99A1AF),
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: widget.deptList.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Color(0xFFF3F4F6),
                    ),
                    itemBuilder: (context, i) {
                      final dept = widget.deptList[i];
                      final isSelected = dept.deptID == _selectedID;
                      return _DeptItem(
                        dept: dept,
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedID = dept.deptID),
                      );
                    },
                  ),
          ),
          _ConfirmButton(
            onTap: () => Navigator.of(context).pop(_selectedID),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '부서 선택',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF101828),
              letterSpacing: 0.07,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFF6A7282),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeptItem extends StatelessWidget {
  final Dept dept;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeptItem({
    required this.dept,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: isSelected
            ? const Color(0xFF00A63E).withValues(alpha: 0.06)
            : Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(
                dept.deptName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? const Color(0xFF00A63E)
                      : const Color(0xFF1E2939),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Color(0xFF00A63E), size: 22),
          ],
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ConfirmButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF00A63E),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              '선택 완료',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.07,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

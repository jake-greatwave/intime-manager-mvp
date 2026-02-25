import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  final DateTime initialDate;

  const CalendarPicker({super.key, required this.initialDate});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late DateTime _displayMonth;
  late DateTime _selectedDate;

  static const _weekdayLabels = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  int _firstWeekdayColumn(int year, int month) =>
      DateTime(year, month, 1).weekday % 7;

  void _prevMonth() => setState(() {
        _displayMonth =
            DateTime(_displayMonth.year, _displayMonth.month - 1);
      });

  void _nextMonth() => setState(() {
        _displayMonth =
            DateTime(_displayMonth.year, _displayMonth.month + 1);
      });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final year = _displayMonth.year;
    final month = _displayMonth.month;
    final daysInMonth = _daysInMonth(year, month);
    final firstCol = _firstWeekdayColumn(year, month);
    final rowCount = ((firstCol + daysInMonth) / 7).ceil();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: BoxDecoration(
              color: const Color(0xFFD6EAF8),
              border: Border.all(color: const Color(0xFF2E4053), width: 6),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(year, month),
                const SizedBox(height: 20),
                _buildWeekdayRow(),
                const SizedBox(height: 8),
                _buildDayGrid(year, month, firstCol, daysInMonth, rowCount),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF2E4053),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int year, int month) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NavButton(onTap: _prevMonth, icon: Icons.chevron_left),
        Text(
          '$year년 $month월',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2E4053),
            letterSpacing: -1.1,
          ),
        ),
        _NavButton(onTap: _nextMonth, icon: Icons.chevron_right),
      ],
    );
  }

  Widget _buildWeekdayRow() {
    return Row(
      children: List.generate(7, (i) {
        return Expanded(
          child: Center(
            child: Text(
              _weekdayLabels[i],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: i == 0
                    ? const Color(0xFFFB2C36)
                    : const Color(0xFF2E4053).withValues(alpha: 0.6),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDayGrid(
    int year,
    int month,
    int firstCol,
    int daysInMonth,
    int rowCount,
  ) {
    return Column(
      children: List.generate(rowCount, (row) {
        return Row(
          children: List.generate(7, (col) {
            final dayNumber = row * 7 + col - firstCol + 1;
            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return const Expanded(child: SizedBox(height: 40));
            }
            final date = DateTime(year, month, dayNumber);
            final isSelected = _isSameDay(date, _selectedDate);
            final isSunday = col == 0;

            return Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(date),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(2),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: const Color(0xFF2E4053),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : null,
                  alignment: Alignment.center,
                  child: Text(
                    '$dayNumber',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isSelected
                          ? Colors.white
                          : isSunday
                              ? const Color(0xFFFB2C36)
                              : const Color(0xFF2E4053),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

class _NavButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const _NavButton({required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: const Color(0xFF2E4053), size: 26),
      ),
    );
  }
}

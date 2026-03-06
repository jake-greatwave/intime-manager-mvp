import 'package:flutter/material.dart';
import 'package:intime_manager/models/type_of_work.dart';

class TypeOfWorkPickerSheet extends StatefulWidget {
  final List<TypeOfWork> typeOfWorkList;
  final int currentTypeOfWorkID;

  const TypeOfWorkPickerSheet({
    super.key,
    required this.typeOfWorkList,
    required this.currentTypeOfWorkID,
  });

  @override
  State<TypeOfWorkPickerSheet> createState() => _TypeOfWorkPickerSheetState();
}

class _TypeOfWorkPickerSheetState extends State<TypeOfWorkPickerSheet> {
  late int _selectedID;

  @override
  void initState() {
    super.initState();
    _selectedID = widget.currentTypeOfWorkID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '공종 선택',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF101828),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.typeOfWorkList.length,
              itemBuilder: (_, i) {
                final tow = widget.typeOfWorkList[i];
                final isSelected = tow.typeOfWorkID == _selectedID;
                return GestureDetector(
                  onTap: () => setState(() => _selectedID = tow.typeOfWorkID),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF0FDF4)
                          : Colors.transparent,
                      border: const Border(
                        bottom: BorderSide(
                            color: Color(0xFFF3F4F6), width: 0.8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            tow.typeOfWorkName,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? const Color(0xFF00A63E)
                                  : const Color(0xFF1E2939),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle,
                              color: Color(0xFF00A63E), size: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              16,
              24,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(_selectedID),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A63E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '선택 완료',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/more/user_info_row.dart';

class UserInfoSection extends StatelessWidget {
  final String enrollNumber;
  final String name;

  const UserInfoSection({
    super.key,
    required this.enrollNumber,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF9FAFB), width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoRow(label: '등록번호', value: enrollNumber),
          const SizedBox(height: 16),
          UserInfoRow(label: '이름', value: name),
        ],
      ),
    );
  }
}

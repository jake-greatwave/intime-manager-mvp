import 'package:flutter/material.dart';

class DeptHintCard extends StatelessWidget {
  final String message;

  const DeptHintCard({
    super.key,
    this.message = '수정하거나 삭제할 부서를 선택해주세요',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE047), width: 2),
      ),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF92400E),
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

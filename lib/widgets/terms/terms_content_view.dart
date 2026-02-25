import 'package:flutter/material.dart';
import 'package:intime_manager/data/terms_content.dart';

class TermsContentView extends StatelessWidget {
  const TermsContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 400,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          TermsContent.content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
            height: 1.8,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}

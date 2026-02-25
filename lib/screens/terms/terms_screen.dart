import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/terms/terms_section_header.dart';
import 'package:intime_manager/widgets/terms/terms_content_view.dart';
import 'package:intime_manager/widgets/terms/next_button.dart';
import 'package:intime_manager/screens/signup/signup_birthday_first_screen.dart';

class TermsScreen extends StatefulWidget {
  final String phoneNumber;
  final String reqTime;

  const TermsScreen({
    super.key,
    required this.phoneNumber,
    required this.reqTime,
  });

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  void _onNext() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupBirthdayFirstScreen(
          phoneNumber: widget.phoneNumber,
          reqTime: widget.reqTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '약관 동의',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const TermsSectionHeader(),
              const SizedBox(height: 16),
              const TermsContentView(),
              const Spacer(),
              NextButton(
                onPressed: _onNext,
                isEnabled: true,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

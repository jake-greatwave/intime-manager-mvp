import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/signup/signup_birthday_title.dart';
import 'package:intime_manager/widgets/signup/signup_birthday_input.dart';
import 'package:intime_manager/widgets/signup/next_button.dart';
import 'package:intime_manager/screens/signup/signup_birthday_second_screen.dart';

class SignupBirthdayFirstScreen extends StatefulWidget {
  final String phoneNumber;
  final String reqTime;

  const SignupBirthdayFirstScreen({
    super.key,
    required this.phoneNumber,
    required this.reqTime,
  });

  @override
  State<SignupBirthdayFirstScreen> createState() => _SignupBirthdayFirstScreenState();
}

class _SignupBirthdayFirstScreenState extends State<SignupBirthdayFirstScreen> {
  String _birthday = '';

  bool get _isBirthdayValid {
    return _birthday.length == 8;
  }

  void _onBirthdayChanged(String value) {
    setState(() {
      _birthday = value;
    });
  }

  void _onNext() {
    if (_isBirthdayValid) {
      HapticFeedback.lightImpact();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignupBirthdaySecondScreen(
            phoneNumber: widget.phoneNumber,
            reqTime: widget.reqTime,
            firstBirthday: _birthday,
          ),
        ),
      );
    }
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const SignupBirthdayTitle(),
              const SizedBox(height: 32),
              SignupBirthdayInput(
                onChanged: _onBirthdayChanged,
              ),
              const Spacer(),
              SignupNextButton(
                onPressed: _isBirthdayValid ? _onNext : null,
                isEnabled: _isBirthdayValid,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

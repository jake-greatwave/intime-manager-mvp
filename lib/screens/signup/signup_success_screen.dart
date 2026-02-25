import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/signup/success/success_icon.dart';
import 'package:intime_manager/widgets/signup/success/success_title.dart';
import 'package:intime_manager/widgets/signup/success/start_button.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const SuccessIcon(),
                const SizedBox(height: 24),
                const SuccessTitle(),
                const SizedBox(height: 32),
                StartButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

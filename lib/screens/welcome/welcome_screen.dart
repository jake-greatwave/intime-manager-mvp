import 'package:flutter/material.dart';
import 'package:intime_manager/screens/welcome/welcome_page_view.dart';
import 'package:intime_manager/services/preference_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WelcomePageView(
          onComplete: () => _navigateToNext(),
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    final hasLoginInfo = await PreferenceService.hasLoginInfo();
    if (!mounted) return;

    final route = hasLoginInfo ? '/home' : '/login';
    Navigator.of(context).pushReplacementNamed(route);
  }
}

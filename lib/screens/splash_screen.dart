import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/splash_content.dart';
import 'package:intime_manager/widgets/splash_progress_indicator.dart';
import 'package:intime_manager/services/preference_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNext();
    });
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    try {
      final shouldSkipWelcome = await PreferenceService.shouldSkipWelcome();
      final hasLoginInfo = await PreferenceService.hasLoginInfo();

      if (!mounted) return;

      String route;
      if (!shouldSkipWelcome) {
        route = '/welcome';
      } else if (hasLoginInfo) {
        route = '/home';
      } else {
        route = '/login';
      }

      Navigator.of(context).pushReplacementNamed(route);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SplashContent(),
            const Spacer(),
            const SplashProgressIndicator(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

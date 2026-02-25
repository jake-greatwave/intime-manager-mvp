import 'package:flutter/material.dart';
import 'package:intime_manager/services/preference_service.dart';
import 'package:intime_manager/widgets/welcome/welcome_page_one.dart';
import 'package:intime_manager/widgets/welcome/welcome_page_two.dart';
import 'package:intime_manager/widgets/welcome/welcome_page_three.dart';
import 'package:intime_manager/widgets/welcome/welcome_page_indicator.dart';
import 'package:intime_manager/widgets/welcome/welcome_action_buttons.dart';

class WelcomePageView extends StatefulWidget {
  final VoidCallback onComplete;

  const WelcomePageView({
    super.key,
    required this.onComplete,
  });

  @override
  State<WelcomePageView> createState() => _WelcomePageViewState();
}

class _WelcomePageViewState extends State<WelcomePageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _skipWelcome = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleComplete();
    }
  }

  void _onSkip() {
    _handleComplete();
  }

  Future<void> _handleComplete() async {
    if (_skipWelcome) {
      await PreferenceService.setSkipWelcome(true);
    }
    widget.onComplete();
  }

  void _onSkipWelcomeChanged(bool value) {
    setState(() {
      _skipWelcome = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: const [
              WelcomePageOne(),
              WelcomePageTwo(),
              WelcomePageThree(),
            ],
          ),
        ),
        WelcomePageIndicator(currentPage: _currentPage),
        const SizedBox(height: 32),
        WelcomeActionButtons(
          currentPage: _currentPage,
          skipWelcome: _skipWelcome,
          onNext: _onNext,
          onSkip: _onSkip,
          onSkipWelcomeChanged: _onSkipWelcomeChanged,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

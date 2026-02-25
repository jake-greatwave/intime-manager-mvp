import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/birthday/birthday_title.dart';
import 'package:intime_manager/widgets/birthday/birthday_input.dart';
import 'package:intime_manager/widgets/birthday/login_button.dart';
import 'package:intime_manager/widgets/birthday/signup_button.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/services/preference_service.dart';
import 'package:intime_manager/screens/terms/terms_screen.dart';

class BirthdayScreen extends StatefulWidget {
  final String phoneNumber;
  final String reqTime;

  const BirthdayScreen({
    super.key,
    required this.phoneNumber,
    required this.reqTime,
  });

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final AuthService _authService = AuthService();
  String _birthday = '';
  bool _isLoading = false;

  bool get _isBirthdayValid {
    return _birthday.length == 8;
  }

  void _onBirthdayChanged(String value) {
    setState(() {
      _birthday = value;
    });
  }

  Future<void> _onLogin() async {
    if (!_isBirthdayValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.lightImpact();

    try {
      final response = await _authService.login(
        loginID: widget.phoneNumber,
        birthDay: _birthday,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        await PreferenceService.saveLoginResponse(response);
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      String errorMessage = '로그인 중 오류가 발생했습니다';

      if (e.toString().contains('Socket')) {
        errorMessage = '서버에 연결할 수 없습니다.\n네트워크 연결을 확인해주세요.';
      } else if (e.toString().contains('timeout') || e.toString().contains('Timeout')) {
        errorMessage = '요청 시간이 초과되었습니다.\n다시 시도해주세요.';
      } else if (e.toString().contains('Failed to parse')) {
        errorMessage = '서버 응답을 처리할 수 없습니다.\n잠시 후 다시 시도해주세요.';
      } else {
        errorMessage = '로그인에 실패했습니다.\n다시 시도해주세요.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSignup() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsScreen(
          phoneNumber: widget.phoneNumber,
          reqTime: widget.reqTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const BirthdayTitle(),
              const SizedBox(height: 32),
              BirthdayInput(
                onChanged: _onBirthdayChanged,
              ),
              const SizedBox(height: 24),
              LoginButton(
                onPressed: _isBirthdayValid && !_isLoading ? _onLogin : null,
                isEnabled: _isBirthdayValid && !_isLoading,
              ),
              const SizedBox(height: 16),
              SignupButton(
                onPressed: _onSignup,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

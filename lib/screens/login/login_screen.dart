import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/login/login_title.dart';
import 'package:intime_manager/widgets/login/phone_number_input.dart';
import 'package:intime_manager/widgets/login/auth_request_button.dart';
import 'package:intime_manager/widgets/login/exit_app_button.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/screens/auth/auth_code_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  String _phoneNumber = '';
  bool _isLoading = false;

  bool get _isPhoneNumberValid {
    final digitsOnly = _phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly.length == 11;
  }

  void _onPhoneNumberChanged(String value) {
    setState(() {
      _phoneNumber = value;
    });
  }

  Future<void> _onAuthRequest() async {
    if (!_isPhoneNumberValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.lightImpact();

    try {
      final digitsOnly = _phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      final reqTime = DateTime.now().toIso8601String();

      final response = await _authService.requestAuthCode(
        phoneNumber: digitsOnly,
        reqTime: reqTime,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AuthCodeScreen(
              phoneNumber: digitsOnly,
              reqTime: reqTime,
            ),
          ),
        );
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

      String errorMessage = '인증번호 요청 중 오류가 발생했습니다';

      if (e.toString().contains('Socket')) {
        errorMessage = '서버에 연결할 수 없습니다.\n네트워크 연결을 확인해주세요.';
      } else if (e.toString().contains('timeout') || e.toString().contains('Timeout')) {
        errorMessage = '요청 시간이 초과되었습니다.\n다시 시도해주세요.';
      } else if (e.toString().contains('Failed to parse')) {
        errorMessage = '서버 응답을 처리할 수 없습니다.\n잠시 후 다시 시도해주세요.';
      } else {
        errorMessage = '인증번호 요청에 실패했습니다.\n다시 시도해주세요.';
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

  void _onExitApp() {
    SystemNavigator.pop();
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
              const LoginTitle(),
              const SizedBox(height: 32),
              PhoneNumberInput(
                onChanged: _onPhoneNumberChanged,
              ),
              const SizedBox(height: 24),
              AuthRequestButton(
                onPressed: _isPhoneNumberValid && !_isLoading ? _onAuthRequest : null,
                isEnabled: _isPhoneNumberValid && !_isLoading,
              ),
              const SizedBox(height: 16),
              ExitAppButton(
                onPressed: _onExitApp,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

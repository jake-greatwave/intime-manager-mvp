import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/auth/auth_code_title.dart';
import 'package:intime_manager/widgets/auth/auth_code_input.dart';
import 'package:intime_manager/widgets/auth/confirm_button.dart';
import 'package:intime_manager/widgets/auth/back_button.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/screens/birthday/birthday_screen.dart';

class AuthCodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String reqTime;

  const AuthCodeScreen({
    super.key,
    required this.phoneNumber,
    required this.reqTime,
  });

  @override
  State<AuthCodeScreen> createState() => _AuthCodeScreenState();
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  final AuthService _authService = AuthService();
  String _authCode = '';
  bool _isLoading = false;

  bool get _isAuthCodeValid {
    return _authCode.length == 4;
  }

  void _onAuthCodeChanged(String value) {
    setState(() {
      _authCode = value;
    });
  }

  Future<void> _onConfirm() async {
    if (!_isAuthCodeValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.lightImpact();

    try {
      final response = await _authService.verifyAuthCode(
        phoneNumber: widget.phoneNumber,
        authCode: _authCode,
        reqTime: widget.reqTime,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BirthdayScreen(
              phoneNumber: widget.phoneNumber,
              reqTime: widget.reqTime,
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

      String errorMessage = '인증번호 확인 중 오류가 발생했습니다';

      if (e.toString().contains('Socket')) {
        errorMessage = '서버에 연결할 수 없습니다.\n네트워크 연결을 확인해주세요.';
      } else if (e.toString().contains('timeout') || e.toString().contains('Timeout')) {
        errorMessage = '요청 시간이 초과되었습니다.\n다시 시도해주세요.';
      } else if (e.toString().contains('Failed to parse')) {
        errorMessage = '서버 응답을 처리할 수 없습니다.\n잠시 후 다시 시도해주세요.';
      } else {
        errorMessage = '인증번호 확인에 실패했습니다.\n다시 시도해주세요.';
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
              const AuthCodeTitle(),
              const SizedBox(height: 40),
              AuthCodeInput(
                onChanged: _onAuthCodeChanged,
              ),
              const SizedBox(height: 32),
              ConfirmButton(
                onPressed: _isAuthCodeValid && !_isLoading ? _onConfirm : null,
                isEnabled: _isAuthCodeValid && !_isLoading,
              ),
              const SizedBox(height: 24),
              const AuthBackButton(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intime_manager/widgets/signup/signup_birthday_title.dart';
import 'package:intime_manager/widgets/signup/signup_birthday_input.dart';
import 'package:intime_manager/widgets/signup/signup_button.dart';
import 'package:intime_manager/services/network/auth_service.dart';
import 'package:intime_manager/screens/signup/signup_success_screen.dart';

class SignupBirthdaySecondScreen extends StatefulWidget {
  final String phoneNumber;
  final String reqTime;
  final String firstBirthday;

  const SignupBirthdaySecondScreen({
    super.key,
    required this.phoneNumber,
    required this.reqTime,
    required this.firstBirthday,
  });

  @override
  State<SignupBirthdaySecondScreen> createState() => _SignupBirthdaySecondScreenState();
}

class _SignupBirthdaySecondScreenState extends State<SignupBirthdaySecondScreen> {
  final AuthService _authService = AuthService();
  String _birthday = '';
  bool _isLoading = false;

  bool get _isBirthdayValid {
    return _birthday.length == 8;
  }

  bool get _isBirthdayMatch {
    return _birthday == widget.firstBirthday;
  }

  void _onBirthdayChanged(String value) {
    setState(() {
      _birthday = value;
    });
  }

  Future<void> _onSignup() async {
    if (!_isBirthdayValid || _isLoading) return;

    HapticFeedback.lightImpact();

    if (!_isBirthdayMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '생년월일이 일치하지 않습니다.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.registerMember(
        loginID: widget.phoneNumber,
        birthDay: _birthday,
      );

      if (!mounted) return;

      if (response.status == 'SUCCESS') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupSuccessScreen(),
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

      String errorMessage = '회원가입 중 오류가 발생했습니다';

      if (e.toString().contains('Socket')) {
        errorMessage = '서버에 연결할 수 없습니다.\n네트워크 연결을 확인해주세요.';
      } else if (e.toString().contains('timeout') || e.toString().contains('Timeout')) {
        errorMessage = '요청 시간이 초과되었습니다.\n다시 시도해주세요.';
      } else if (e.toString().contains('Failed to parse')) {
        errorMessage = '서버 응답을 처리할 수 없습니다.\n잠시 후 다시 시도해주세요.';
      } else {
        errorMessage = '회원가입에 실패했습니다.\n다시 시도해주세요.';
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
              SignupButton(
                onPressed: _isBirthdayValid && !_isLoading ? _onSignup : null,
                isEnabled: _isBirthdayValid && !_isLoading,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SuccessTitle extends StatelessWidget {
  const SuccessTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Text(
            '축하합니다!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              letterSpacing: -0.5,
            ),
          ),
          const Text(
            '얼굴도장 서비스에',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
              letterSpacing: -0.3,
            ),
          ),
          const Text(
            'VIP 관리자로 가입 되었습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4CAF50),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '이제 부서와 근로자 관리를\n스마트폰에서 간단히 하실 수\n있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              letterSpacing: -0.3,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '어려운 일은 저희 고객센터에서\n최선을 다해 도와 드리겠습니다\n전화만 주세요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              letterSpacing: -0.3,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '1544-7411',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              letterSpacing: 1,
            ),
          ),
          const Text(
            '오전8시~오후5시',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              letterSpacing: -0.3,
            ),
          ),
        ],
    );
  }
}

import 'package:intime_manager/models/request/socket_request.dart';

class VerifyRequest implements SocketRequest {
  @override
  final String type = 'VERIFY_AUTH';
  final String reqTime;
  final String phoneNumber;
  final String authCode;

  VerifyRequest({
    required this.reqTime,
    required this.phoneNumber,
    required this.authCode,
  });

  factory VerifyRequest.fromJson(Map<String, dynamic> json) {
    return VerifyRequest(
      reqTime: json['reqTime'] as String,
      phoneNumber: json['phoneNumber'] as String,
      authCode: json['authCode'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'reqTime': reqTime,
      'phoneNumber': phoneNumber,
      'authCode': authCode,
    };
  }
}

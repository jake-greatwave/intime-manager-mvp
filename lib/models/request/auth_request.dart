import 'package:intime_manager/models/request/socket_request.dart';

class AuthRequest implements SocketRequest {
  @override
  final String type = 'REQ_AUTH';
  final String reqTime;
  final String phoneNumber;

  AuthRequest({
    required this.reqTime,
    required this.phoneNumber,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      reqTime: json['reqTime'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'reqTime': reqTime,
      'phoneNumber': phoneNumber,
    };
  }
}

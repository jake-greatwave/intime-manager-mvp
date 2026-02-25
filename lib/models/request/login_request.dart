import 'package:intime_manager/models/request/socket_request.dart';

class LoginRequest implements SocketRequest {
  @override
  final String type = 'REQ_LOG_IN';
  final String loginID;
  final String birthDay;

  LoginRequest({
    required this.loginID,
    required this.birthDay,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      loginID: json['loginID'] as String,
      birthDay: json['birthDay'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'loginID': loginID,
      'birthDay': birthDay,
    };
  }
}

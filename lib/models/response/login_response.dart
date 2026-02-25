import 'package:intime_manager/models/response/socket_response.dart';
import 'package:intime_manager/models/corporation.dart';

class LoginResponse implements SocketResponse {
  @override
  final String status;
  @override
  final String message;
  final List<Corporation> corporations;

  LoginResponse({
    required this.status,
    required this.message,
    this.corporations = const [],
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      corporations: (json['Corporations'] as List<dynamic>?)
              ?.map((e) => Corporation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'Corporations': corporations.map((e) => e.toJson()).toList(),
    };
  }
}

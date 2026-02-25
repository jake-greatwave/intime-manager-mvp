import 'package:intime_manager/models/response/socket_response.dart';

class GenericResponse implements SocketResponse {
  @override
  final String status;
  @override
  final String message;

  GenericResponse({
    required this.status,
    required this.message,
  });

  factory GenericResponse.fromJson(Map<String, dynamic> json) {
    return GenericResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}

import 'package:intime_manager/models/request/socket_request.dart';

class RegMemberRequest implements SocketRequest {
  @override
  final String type = 'REQ_REG_MEMBER';
  final String loginID;
  final String birthDay;

  RegMemberRequest({
    required this.loginID,
    required this.birthDay,
  });

  factory RegMemberRequest.fromJson(Map<String, dynamic> json) {
    return RegMemberRequest(
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

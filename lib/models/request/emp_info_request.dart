import 'package:intime_manager/models/request/socket_request.dart';

class EmpInfoRequest implements SocketRequest {
  @override
  final String type = 'REQ_EMP_INFO';
  final int companyID;
  final int fieldID;
  final String enrollID;

  EmpInfoRequest({
    required this.companyID,
    required this.fieldID,
    required this.enrollID,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
      'EnrollID': enrollID,
    };
  }
}

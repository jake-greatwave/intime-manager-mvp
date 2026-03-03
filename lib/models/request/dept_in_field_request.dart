import 'package:intime_manager/models/request/socket_request.dart';

class DeptInFieldRequest implements SocketRequest {
  @override
  final String type = 'REQ_DEPT_IN_FIELD';
  final int companyID;
  final int fieldID;

  DeptInFieldRequest({required this.companyID, required this.fieldID});

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
    };
  }
}

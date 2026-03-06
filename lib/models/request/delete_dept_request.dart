import 'package:intime_manager/models/request/socket_request.dart';

class DeleteDeptRequest implements SocketRequest {
  @override
  final String type = 'REQ_DEL_DEPT';
  final int companyID;
  final int fieldID;
  final int deptID;

  DeleteDeptRequest({
    required this.companyID,
    required this.fieldID,
    required this.deptID,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
      'DeptID': deptID,
    };
  }
}

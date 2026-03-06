import 'package:intime_manager/models/request/socket_request.dart';

class UpdateDeptRequest implements SocketRequest {
  @override
  final String type = 'REQ_EDIT_DEPT';
  final int companyID;
  final int fieldID;
  final int deptID;
  final int typeOfWorkID;
  final String deptName;

  UpdateDeptRequest({
    required this.companyID,
    required this.fieldID,
    required this.deptID,
    required this.typeOfWorkID,
    required this.deptName,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
      'DeptID': deptID,
      'TypeOfWorkID': typeOfWorkID,
      'DeptName': deptName,
    };
  }
}

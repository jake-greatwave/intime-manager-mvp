import 'package:intime_manager/models/request/socket_request.dart';

class AddDeptRequest implements SocketRequest {
  @override
  final String type = 'REQ_ADD_DEPT';
  final int companyID;
  final int fieldID;
  final String deptName;
  final int typeOfWorkID;

  AddDeptRequest({
    required this.companyID,
    required this.fieldID,
    required this.deptName,
    required this.typeOfWorkID,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
      'DeptName': deptName,
      'TypeOfWorkID': typeOfWorkID,
    };
  }
}

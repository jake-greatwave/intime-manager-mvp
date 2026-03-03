import 'package:intime_manager/models/emp_detail.dart';
import 'package:intime_manager/models/request/socket_request.dart';

class UpdateEmpInfoRequest implements SocketRequest {
  @override
  final String type = 'REQ_UPDATE_EMP_INFO';
  final EmpDetail empDetail;

  UpdateEmpInfoRequest({required this.empDetail});

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'EmpDetail': empDetail.toJson(),
    };
  }
}

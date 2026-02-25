import 'package:intime_manager/models/request/socket_request.dart';

class WorkInfoRequest implements SocketRequest {
  @override
  final String type = 'REQ_WORKING_INFO';
  final int companyID;
  final int fieldID;
  final String fieldCode;
  final String workDate;

  WorkInfoRequest({
    required this.companyID,
    required this.fieldID,
    required this.fieldCode,
    required this.workDate,
  });

  factory WorkInfoRequest.fromJson(Map<String, dynamic> json) {
    return WorkInfoRequest(
      companyID: json['CompanyID'] as int,
      fieldID: json['FieldID'] as int,
      fieldCode: json['FieldCode'] as String,
      workDate: json['WorkDate'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'CompanyID': companyID,
      'FieldID': fieldID,
      'FieldCode': fieldCode,
      'WorkDate': workDate,
    };
  }
}

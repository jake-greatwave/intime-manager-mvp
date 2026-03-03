import 'package:intime_manager/models/dept.dart';
import 'package:intime_manager/models/emp_detail.dart';
import 'package:intime_manager/models/response/socket_response.dart';

class EmpInfoResponse implements SocketResponse {
  @override
  final String status;
  @override
  final String message;
  final EmpDetail? empDetail;
  final List<Dept> deptInField;

  EmpInfoResponse({
    required this.status,
    required this.message,
    this.empDetail,
    this.deptInField = const [],
  });

  factory EmpInfoResponse.fromJson(Map<String, dynamic> json) {
    EmpDetail? detail;
    final rawDetail = json['EmpDetail'] ?? json['empDetail'];
    if (rawDetail is Map) {
      try {
        detail = EmpDetail.fromJson(Map<String, dynamic>.from(rawDetail));
      } catch (_) {}
    }

    return EmpInfoResponse(
      status: (json['status'] as String?) ?? '',
      message: (json['message'] as String?) ?? '',
      empDetail: detail,
      deptInField: _parseDeptList(json['DeptInField'] ?? json['deptInField']),
    );
  }

  static List<Dept> _parseDeptList(dynamic list) {
    if (list == null || list is! List) return [];
    final result = <Dept>[];
    for (final e in list) {
      try {
        final map = e is Map ? Map<String, dynamic>.from(e) : null;
        if (map != null) result.add(Dept.fromJson(map));
      } catch (_) {}
    }
    return result;
  }
}

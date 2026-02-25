import 'package:intime_manager/models/response/socket_response.dart';
import 'package:intime_manager/models/emp_working_info.dart';

class EmpWorkingInfoResponse implements SocketResponse {
  @override
  final String status;
  @override
  final String message;
  final List<EmpWorkingInfo> empWorkingInfo;

  EmpWorkingInfoResponse({
    required this.status,
    required this.message,
    this.empWorkingInfo = const [],
  });

  factory EmpWorkingInfoResponse.fromJson(Map<String, dynamic> json) {
    final list = json['EmpWorkingInfo'] ?? json['empWorkingInfo'];
    return EmpWorkingInfoResponse(
      status: (json['status'] as String?) ?? '',
      message: (json['message'] as String?) ?? '',
      empWorkingInfo: _parseEmpWorkingInfoList(list),
    );
  }

  static List<EmpWorkingInfo> _parseEmpWorkingInfoList(dynamic list) {
    if (list == null || list is! List) return [];
    final result = <EmpWorkingInfo>[];
    for (final e in list) {
      try {
        final map = e is Map ? Map<String, dynamic>.from(e) : null;
        if (map != null) {
          result.add(EmpWorkingInfo.fromJson(map));
        }
      } catch (_) {}
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'EmpWorkingInfo': empWorkingInfo.map((e) => e.toJson()).toList(),
    };
  }
}

import 'package:intime_manager/models/dept.dart';
import 'package:intime_manager/models/response/socket_response.dart';
import 'package:intime_manager/models/type_of_work.dart';

class DeptInFieldResponse implements SocketResponse {
  @override
  final String status;
  @override
  final String message;
  final List<TypeOfWork> typeOfWork;
  final List<Dept> deptInField;

  DeptInFieldResponse({
    required this.status,
    required this.message,
    this.typeOfWork = const [],
    this.deptInField = const [],
  });

  factory DeptInFieldResponse.fromJson(Map<String, dynamic> json) {
    final towList = _parseTypeOfWork(json['TypeOfWork'] ?? json['typeOfWork']);
    final towMap = {for (final t in towList) t.typeOfWorkID: t.typeOfWorkName};
    final rawDepts = _parseDeptList(json['DeptInField'] ?? json['deptInField']);
    final depts = rawDepts.map((d) {
      final name = towMap[d.typeOfWorkID] ?? '';
      return name.isNotEmpty ? d.copyWithTypeOfWorkName(name) : d;
    }).toList();

    return DeptInFieldResponse(
      status: (json['status'] as String?) ?? '',
      message: (json['message'] as String?) ?? '',
      typeOfWork: towList,
      deptInField: depts,
    );
  }

  static List<TypeOfWork> _parseTypeOfWork(dynamic list) {
    if (list == null || list is! List) return [];
    final result = <TypeOfWork>[];
    for (final e in list) {
      try {
        final map = e is Map ? Map<String, dynamic>.from(e) : null;
        if (map != null) result.add(TypeOfWork.fromJson(map));
      } catch (_) {}
    }
    return result;
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

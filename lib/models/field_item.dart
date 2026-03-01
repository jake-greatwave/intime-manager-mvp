import 'package:intime_manager/models/emp_working_info.dart';

class FieldItem {
  final int companyID;
  final String companyName;
  final int fieldID;
  final String fieldCode;
  final String fieldName;
  final int workerCount;
  final int notOut;
  final int unassigned;
  final List<EmpWorkingInfo> empList;

  const FieldItem({
    required this.companyID,
    required this.companyName,
    required this.fieldID,
    required this.fieldCode,
    required this.fieldName,
    this.workerCount = 0,
    this.notOut = 0,
    this.unassigned = 0,
    this.empList = const [],
  });

  FieldItem copyWith({
    int? workerCount,
    int? notOut,
    int? unassigned,
    List<EmpWorkingInfo>? empList,
  }) {
    return FieldItem(
      companyID: companyID,
      companyName: companyName,
      fieldID: fieldID,
      fieldCode: fieldCode,
      fieldName: fieldName,
      workerCount: workerCount ?? this.workerCount,
      notOut: notOut ?? this.notOut,
      unassigned: unassigned ?? this.unassigned,
      empList: empList ?? this.empList,
    );
  }
}

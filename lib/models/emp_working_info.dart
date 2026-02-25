class EmpWorkingInfo {
  final String enrollID;
  final String empName;
  final String deptID;
  final String deptName;
  final String workIn;
  final String workOut;
  final bool workingDone;
  final String lastAuthLog;

  EmpWorkingInfo({
    required this.enrollID,
    required this.empName,
    required this.deptID,
    required this.deptName,
    required this.workIn,
    required this.workOut,
    required this.workingDone,
    required this.lastAuthLog,
  });

  factory EmpWorkingInfo.fromJson(Map<String, dynamic> json) {
    return EmpWorkingInfo(
      enrollID: (json['EnrollID'] ?? json['enrollID'] ?? '').toString(),
      empName: (json['EmpName'] ?? json['empName'] ?? '').toString(),
      deptID: (json['DeptID'] ?? json['deptID'] ?? '').toString(),
      deptName: (json['DeptName'] ?? json['deptName'] ?? '').toString(),
      workIn: (json['WorkIn'] ?? json['workIn'] ?? '').toString(),
      workOut: (json['WorkOut'] ?? json['workOut'] ?? '').toString(),
      workingDone: json['WorkingDone'] == true || json['workingDone'] == true,
      lastAuthLog: (json['LastAuthLog'] ?? json['lastAuthLog'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EnrollID': enrollID,
      'EmpName': empName,
      'DeptID': deptID,
      'DeptName': deptName,
      'WorkIn': workIn,
      'WorkOut': workOut,
      'WorkingDone': workingDone,
      'LastAuthLog': lastAuthLog,
    };
  }
}

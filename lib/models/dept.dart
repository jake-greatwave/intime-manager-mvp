class Dept {
  final int deptID;
  final String deptName;

  Dept({required this.deptID, required this.deptName});

  factory Dept.fromJson(Map<String, dynamic> json) {
    return Dept(
      deptID: (json['DeptID'] ?? json['deptID'] ?? 0) as int,
      deptName: (json['DeptName'] ?? json['deptName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DeptID': deptID,
      'DeptName': deptName,
    };
  }
}

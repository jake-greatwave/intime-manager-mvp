class Dept {
  final int deptID;
  final String deptName;
  final String typeOfWorkName;

  Dept({
    required this.deptID,
    required this.deptName,
    this.typeOfWorkName = '',
  });

  factory Dept.fromJson(Map<String, dynamic> json) {
    return Dept(
      deptID: (json['DeptID'] ?? json['deptID'] ?? 0) as int,
      deptName: (json['DeptName'] ?? json['deptName'] ?? '').toString(),
      typeOfWorkName:
          (json['TypeOfWorkName'] ?? json['typeOfWorkName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DeptID': deptID,
      'DeptName': deptName,
      'TypeOfWorkName': typeOfWorkName,
    };
  }
}

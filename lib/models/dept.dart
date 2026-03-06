class Dept {
  final int deptID;
  final String deptName;
  final int typeOfWorkID;
  final String typeOfWorkName;

  Dept({
    required this.deptID,
    required this.deptName,
    this.typeOfWorkID = 0,
    this.typeOfWorkName = '',
  });

  factory Dept.fromJson(Map<String, dynamic> json) {
    return Dept(
      deptID: (json['DeptID'] ?? json['deptID'] ?? 0) as int,
      deptName: (json['DeptName'] ?? json['deptName'] ?? '').toString(),
      typeOfWorkID:
          (json['TypeOfWorkID'] ?? json['typeOfWorkID'] ?? 0) as int,
      typeOfWorkName:
          (json['TypeOfWorkName'] ?? json['typeOfWorkName'] ?? '').toString(),
    );
  }

  Dept copyWithTypeOfWorkName(String name) {
    return Dept(
      deptID: deptID,
      deptName: deptName,
      typeOfWorkID: typeOfWorkID,
      typeOfWorkName: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DeptID': deptID,
      'DeptName': deptName,
      'TypeOfWorkID': typeOfWorkID,
      'TypeOfWorkName': typeOfWorkName,
    };
  }
}

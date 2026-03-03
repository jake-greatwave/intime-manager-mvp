class EmpDetail {
  final int companyID;
  final int fieldID;
  final String enrollID;
  final int deptID;
  final int teamID;
  final int quit;
  final int noDev;
  final String empName;
  final String phoneNum;
  final String birthDay;
  final String regDate;
  final int imageSize;
  final String base64StringImage;

  EmpDetail({
    required this.companyID,
    required this.fieldID,
    required this.enrollID,
    required this.deptID,
    required this.teamID,
    required this.quit,
    required this.noDev,
    required this.empName,
    required this.phoneNum,
    required this.birthDay,
    required this.regDate,
    required this.imageSize,
    required this.base64StringImage,
  });

  factory EmpDetail.fromJson(Map<String, dynamic> json) {
    return EmpDetail(
      companyID: (json['CompanyID'] ?? 0) as int,
      fieldID: (json['FieldID'] ?? 0) as int,
      enrollID: (json['EnrollID'] ?? '').toString(),
      deptID: (json['DeptID'] ?? 0) as int,
      teamID: (json['TeamID'] ?? 0) as int,
      quit: (json['Quit'] ?? 0) as int,
      noDev: (json['NoDev'] ?? 0) as int,
      empName: (json['EmpName'] ?? '').toString(),
      phoneNum: (json['PhoneNum'] ?? '').toString(),
      birthDay: (json['BirthDay'] ?? '').toString(),
      regDate: (json['Reg_Date'] ?? '').toString(),
      imageSize: (json['Image_Size'] ?? 0) as int,
      base64StringImage: (json['Base64String_Image'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CompanyID': companyID,
      'FieldID': fieldID,
      'EnrollID': enrollID,
      'DeptID': deptID,
      'TeamID': teamID,
      'Quit': quit,
      'NoDev': noDev,
      'EmpName': empName,
      'PhoneNum': phoneNum,
      'BirthDay': birthDay,
      'Reg_Date': regDate,
      'Image_Size': imageSize,
      'Base64String_Image': base64StringImage,
    };
  }

  EmpDetail copyWith({
    int? deptID,
    int? teamID,
    String? empName,
    String? phoneNum,
    String? birthDay,
  }) {
    return EmpDetail(
      companyID: companyID,
      fieldID: fieldID,
      enrollID: enrollID,
      deptID: deptID ?? this.deptID,
      teamID: teamID ?? this.teamID,
      quit: quit,
      noDev: noDev,
      empName: empName ?? this.empName,
      phoneNum: phoneNum ?? this.phoneNum,
      birthDay: birthDay ?? this.birthDay,
      regDate: regDate,
      imageSize: imageSize,
      base64StringImage: base64StringImage,
    );
  }
}

import 'package:intime_manager/models/field.dart';

class Corporation {
  final int companyID;
  final String corporateRegNum;
  final String companyName;
  final List<Field> fields;

  Corporation({
    required this.companyID,
    required this.corporateRegNum,
    required this.companyName,
    required this.fields,
  });

  factory Corporation.fromJson(Map<String, dynamic> json) {
    return Corporation(
      companyID: json['CompanyID'] as int,
      corporateRegNum: json['CorporateRegNum'] as String,
      companyName: json['CompanyName'] as String,
      fields: (json['Fields'] as List<dynamic>?)
              ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CompanyID': companyID,
      'CorporateRegNum': corporateRegNum,
      'CompanyName': companyName,
      'Fields': fields.map((e) => e.toJson()).toList(),
    };
  }
}

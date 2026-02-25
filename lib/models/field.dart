class Field {
  final int companyID;
  final int fieldID;
  final String fieldCode;
  final String fieldName;
  final int usingField;

  Field({
    required this.companyID,
    required this.fieldID,
    required this.fieldCode,
    required this.fieldName,
    required this.usingField,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      companyID: json['CompanyID'] as int,
      fieldID: json['FieldID'] as int,
      fieldCode: json['FieldCode'] as String,
      fieldName: json['FieldName'] as String,
      usingField: json['UsingField'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CompanyID': companyID,
      'FieldID': fieldID,
      'FieldCode': fieldCode,
      'FieldName': fieldName,
      'UsingField': usingField,
    };
  }
}

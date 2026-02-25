class FieldItem {
  final int companyID;
  final String companyName;
  final int fieldID;
  final String fieldCode;
  final String fieldName;
  final int workerCount;

  const FieldItem({
    required this.companyID,
    required this.companyName,
    required this.fieldID,
    required this.fieldCode,
    required this.fieldName,
    this.workerCount = 0,
  });

  FieldItem copyWith({int? workerCount}) {
    return FieldItem(
      companyID: companyID,
      companyName: companyName,
      fieldID: fieldID,
      fieldCode: fieldCode,
      fieldName: fieldName,
      workerCount: workerCount ?? this.workerCount,
    );
  }
}

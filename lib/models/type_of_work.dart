class TypeOfWork {
  final int typeOfWorkID;
  final String typeOfWorkName;

  TypeOfWork({required this.typeOfWorkID, required this.typeOfWorkName});

  factory TypeOfWork.fromJson(Map<String, dynamic> json) {
    return TypeOfWork(
      typeOfWorkID: (json['TypeOfWorkID'] ?? json['typeOfWorkID'] ?? 0) as int,
      typeOfWorkName:
          (json['TypeOfWorkName'] ?? json['typeOfWorkName'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TypeOfWorkID': typeOfWorkID,
      'TypeOfWorkName': typeOfWorkName,
    };
  }
}

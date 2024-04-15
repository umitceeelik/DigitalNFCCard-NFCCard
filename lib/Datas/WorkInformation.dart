class WorkInformation {
  late String companyName;
  late String jobTitle;
  late String? taxId;
  late String? iban;

  WorkInformation({
    required this.companyName,
    required this.jobTitle,
    this.taxId,
    this.iban,
  });

  // Add this factory method to deserialize JSON into a WorkInformation object
  factory WorkInformation.fromJson(Map<String, dynamic> json) {
    return WorkInformation(
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      taxId: json['taxId'],
      iban: json['iban'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'jobTitle': jobTitle,
      'taxId': taxId,
      'iban': iban,
    };
  }
}
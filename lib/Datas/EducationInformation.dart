class EducationInformation {
  late String schoolName;
  late String degree;
  late String fieldOfStudy;
  late String startingDate;
  late String endingDate;

  EducationInformation({
    required this.schoolName,
    required this.degree,
    required this.fieldOfStudy,
    required this.startingDate,
    required this.endingDate,
  });

  // Add this factory method to deserialize JSON into an EducationInformation object
  factory EducationInformation.fromJson(Map<String, dynamic> json) {
    return EducationInformation(
      schoolName: json['schoolName'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      startingDate: json['startingDate'],
      endingDate: json['endingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startingDate': startingDate,
      'endingDate': endingDate,
    };
  }
}
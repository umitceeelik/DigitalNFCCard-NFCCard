class CardInformation{
  late String name;
  late String idNumber;

  CardInformation({
    required this.name,
    required this.idNumber,
  });

  // Add this factory method to deserialize JSON into an EducationInformation object
  factory CardInformation.fromJson(Map<String, dynamic> json) {
    return CardInformation(
      name: json['name'],
      idNumber: json['idNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'idNumber': idNumber,
    };
  }
}
class LinkInformation{
  late String name;
  late String url;

  LinkInformation({
    required this.name,
    required this.url,
  });

  // Add this factory method to deserialize JSON into an EducationInformation object
  factory LinkInformation.fromJson(Map<String, dynamic> json) {
    return LinkInformation(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
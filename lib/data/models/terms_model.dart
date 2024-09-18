class TermsModel {
  late int id;
  late String? title;
  late String? description;

  TermsModel(
      {required this.description, required this.id, required this.title});
  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      description: json['description'],
      id: json['id'],
      title: json['title'],
    );
  }
}

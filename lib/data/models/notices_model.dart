class NoticesModel {
  late String title;
  late String message;
  late DateTime createDate;
  late bool isRead;

  NoticesModel(
      {required this.createDate,
      required this.message,
      required this.title,
      required this.isRead});
  factory NoticesModel.fromJson(Map<String, dynamic> json) {
    return NoticesModel(
        createDate: DateTime.parse(json['createDate']),
        message: json['message'],
        title: json['title'],
        isRead: json['isRead']);
  }
}

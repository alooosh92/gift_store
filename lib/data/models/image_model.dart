class ImageModel {
  late String? type;
  late String? url;

  ImageModel({required this.type, required this.url});
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      type: json['type'],
      url: json['url'],
    );
  }
}

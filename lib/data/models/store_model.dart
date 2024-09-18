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

class StoreModel {
  late String id;
  late String name;
  late String description;
  late String region;
  late double rate;
  late double numRate;
  late String type;
  late double late;
  late double long;
  late String phone;
  late String mobile;
  late double balance;
  late bool? favorate;
  late String? favorateId;
  late List<ImageModel> listImage;

  StoreModel({
    required this.balance,
    required this.description,
    required this.id,
    required this.late,
    required this.listImage,
    required this.long,
    required this.mobile,
    required this.name,
    required this.numRate,
    required this.phone,
    required this.rate,
    required this.region,
    required this.type,
    this.favorate,
    this.favorateId,
  });
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    List<ImageModel> li = [];
    for (var element in json['listImage']) {
      li.add(ImageModel.fromJson(element));
    }
    return StoreModel(
      balance: double.parse(json['balance'].toString()),
      description: json['description'],
      id: json['id'],
      late: double.parse(json['late'].toString()),
      listImage: li,
      long: double.parse(json['long'].toString()),
      mobile: json['mobile'],
      name: json['name'],
      numRate: double.parse(json['numRate'].toString()),
      phone: json['phone'],
      rate: double.parse(json['rate'].toString()),
      region: json['region'],
      type: json['type'],
    );
  }
}

import 'package:gift_store/data/models/image_model.dart';

class GiftModel {
  late String id;
  late String name;
  late String miniDescription;
  late String description;
  late double rate;
  late double numRate;
  late double price;
  late String storeId;
  late String storeName;
  late String region;
  late bool enabled;
  late bool? favorate;
  late String? favorateId;
  late List<ImageModel> giftImages;

  GiftModel({
    required this.description,
    required this.enabled,
    required this.giftImages,
    required this.id,
    required this.miniDescription,
    required this.name,
    required this.numRate,
    required this.price,
    required this.rate,
    required this.region,
    required this.storeId,
    this.favorate,
    this.favorateId,
    required this.storeName,
  });
  factory GiftModel.fromJson(Map<String, dynamic> json) {
    List<ImageModel> li = [];
    for (var element in json['giftImages']) {
      li.add(ImageModel.fromJson(element));
    }
    return GiftModel(
      description: json['description'],
      enabled: json['enabled'],
      giftImages: li,
      id: json['id'],
      miniDescription: json['miniDescription'],
      name: json['name'],
      numRate: double.parse(json['numRate'].toString()),
      price: double.parse(json['price'].toString()),
      rate: double.parse(json['rate'].toString()),
      region: json['region'],
      storeId: json['storeId'],
      storeName: json['storeName'],
    );
  }
}

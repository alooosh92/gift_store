class ItemsModel {
  late String id;
  late String giftName;
  late double rate;
  late double numRate;
  late double price;
  late int number;
  late String url;

  ItemsModel({
    required this.giftName,
    required this.id,
    required this.numRate,
    required this.number,
    required this.price,
    required this.rate,
    required this.url,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      giftName: json['giftName'],
      id: json['id'],
      numRate: double.parse(json['numRate'].toString()),
      number: json['number'],
      price: double.parse(json['price'].toString()),
      rate: double.parse(json['rate'].toString()),
      url: json['url'],
    );
  }
}

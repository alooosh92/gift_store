class FavoriteGiftModel {
  late String id;
  late String gift;

  FavoriteGiftModel({
    required this.id,
    required this.gift,
  });
  factory FavoriteGiftModel.fromJson(Map<String, dynamic> json) {
    return FavoriteGiftModel(id: json['id'], gift: json['store']);
  }
  Map<String, dynamic> toJson() => {"person": id, "store": gift};
}

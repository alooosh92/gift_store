class FavoriteModel {
  late String id;
  late String store;

  FavoriteModel({
    required this.id,
    required this.store,
  });
  factory FavoriteModel.fromJson(Map<String, dynamic> json, String type) {
    return FavoriteModel(id: json['id'], store: json[type]);
  }
}

class FavoriteStoreModel {
  late String id;
  late String store;

  FavoriteStoreModel({
    required this.id,
    required this.store,
  });
  factory FavoriteStoreModel.fromJson(Map<String, dynamic> json) {
    return FavoriteStoreModel(id: json['id'], store: json['store']);
  }
  Map<String, dynamic> toJson() => {"person": id, "store": store};
}

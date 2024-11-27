class ItemModel {
  late String giftId;
  late String orderId;
  late int number;

  ItemModel(
      {required this.giftId, required this.number, required this.orderId});

  Map<String, dynamic> toJson() =>
      {"giftId": giftId, "orderId": orderId, "number": number};
}

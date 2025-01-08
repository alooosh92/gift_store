import 'package:gift_store/data/models/items_model.dart';

class ViewOrderModel {
  late String id;
  late DateTime createDate;
  late DateTime? verificationDate;
  late DateTime? approvalDate;
  late DateTime? readyDate;
  late DateTime? waitingForDeliveryDate;
  late DateTime? deliveryDate;
  late double late;
  late double long;
  late String notes;
  late String address;
  late String orderStatus;
  late String fromName;
  late String fromPhone;
  late String toName;
  late String toPhone;
  late String? deliveryCompanyName;
  late String idStore;
  late String storeName;
  late String? url;
  late String region;
  late List<ItemsModel> items;
  late double totalPrice;
  late double offer;
  late double totalPriceAfterOffer;

  ViewOrderModel(
      {required this.id,
      required this.createDate,
      required this.verificationDate,
      required this.approvalDate,
      required this.readyDate,
      required this.waitingForDeliveryDate,
      required this.deliveryDate,
      required this.late,
      required this.long,
      required this.notes,
      required this.address,
      required this.orderStatus,
      required this.fromName,
      required this.fromPhone,
      required this.toName,
      required this.toPhone,
      required this.deliveryCompanyName,
      required this.idStore,
      required this.storeName,
      required this.url,
      required this.region,
      required this.items,
      required this.totalPrice,
      required this.offer,
      required this.totalPriceAfterOffer});

  factory ViewOrderModel.fromJson(Map<String, dynamic> json) {
    List<ItemsModel> items = [];
    double price = 0;
    for (var element in json['items']) {
      ItemsModel item = ItemsModel.fromJson(element);
      items.add(item);
      price += item.price * item.number;
    }
    return ViewOrderModel(
        address: json['address'],
        approvalDate: json['approvalDate'] != null
            ? DateTime.parse(json['approvalDate'].toString())
            : null,
        createDate: DateTime.parse(json['createDate'].toString()),
        deliveryCompanyName: json['deliveryCompanyName'],
        deliveryDate: json['deliveryDate'] != null
            ? DateTime.parse(json['deliveryDate'].toString())
            : null,
        fromName: json['fromName'],
        fromPhone: json['fromPhone'],
        id: json['id'],
        idStore: json['idStore'],
        items: items,
        late: double.parse(json['late'].toString()),
        long: double.parse(json['long'].toString()),
        notes: json['notes'],
        orderStatus: json['orderStatus'],
        readyDate: json['readyDate'] != null
            ? DateTime.parse(json['readyDate'].toString())
            : null,
        region: json['region'],
        storeName: json['storeName'],
        toName: json['toName'],
        toPhone: json['toPhone'],
        url: json['url'],
        verificationDate: json['verificationDate'] != null
            ? DateTime.parse(json['verificationDate'].toString())
            : null,
        waitingForDeliveryDate: json['waitingForDeliveryDate'] != null
            ? DateTime.parse(json['waitingForDeliveryDate'].toString())
            : null,
        totalPrice: price,
        offer: double.parse(json['offers'].toString()),
        totalPriceAfterOffer: price - double.parse(json['offers'].toString()));
  }

  get isRead => null;
}

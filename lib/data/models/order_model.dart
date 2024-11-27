class OrderModel {
  late double late;
  late double long;
  late String name;
  late String phone;
  late String? notes;
  late String address;
  late String store;

  OrderModel({
    required this.late,
    required this.long,
    required this.address,
    required this.name,
    required this.notes,
    required this.phone,
    required this.store,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      late: json['late'],
      long: json['long'],
      address: json['address'],
      name: json['name'],
      notes: json['notes'],
      phone: json['phone'],
      store: json['store'],
    );
  }
  Map<String, dynamic> tojson() => {
        'late': late,
        'long': long,
        'store': store,
        'address': address,
        'name': name,
        'notes': notes,
        'phone': phone,
      };
}

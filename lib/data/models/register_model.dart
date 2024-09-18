class RegisterModel {
  late String fullName;
  late String phone;

  RegisterModel({
    required this.fullName,
    required this.phone,
  });
  Map<String, dynamic> toJson() => {"fullName": fullName, "userName": phone};
}

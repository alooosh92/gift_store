class OtpModel {
  late String phone;
  late int code;

  OtpModel({required this.code, required this.phone});

  Map<String, dynamic> toJson() => {"code": code, "userName": phone};
}

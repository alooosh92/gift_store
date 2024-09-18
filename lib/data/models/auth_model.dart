class AuthModel {
  late String? message;
  late bool isAuthanticated;
  late String? phone;
  late List<String> roles;
  late String? token;
  late String? refreshToken;
  late String? refreshTokenExpireson;

  AuthModel({
    required this.isAuthanticated,
    required this.message,
    required this.phone,
    required this.refreshToken,
    required this.refreshTokenExpireson,
    required this.roles,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    List<String> ro = [];
    for (var element in json['roles'] ?? []) {
      ro.add(element);
    }
    return AuthModel(
      isAuthanticated: json['isAuthanticated'],
      message: json['message'],
      phone: json['phone'],
      refreshToken: json['refreshToken'],
      refreshTokenExpireson: json['refreshTokenExpireson'],
      roles: ro,
      token: json['token'],
    );
  }
}

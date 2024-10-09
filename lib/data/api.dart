import 'package:get_storage/get_storage.dart';

class Api {
  var storage = GetStorage();
  static const String _hostting = "https://10.0.2.2:7253";
  static const String storeImage = "$_hostting/images/store";
  static const String storeGift = "$_hostting/images/Gift";
  static const String _api = "$_hostting/api";
  Map<String, String> headerWithToken() {
    var token = "Bearer ${storage.read("token")}";
    return {
      "Authorization": token,
      "Accept": "*/*",
      "Content-Type": "application/json"
    };
  }

  Map<String, String> header() {
    return {"Accept": "*/*", "Content-Type": "application/json"};
  }

  static const String _authentication = "$_api/Authentication";
  // Map<String, String> header() =>
  //     {"Content-Type": "", "Authorization": "Bearer ${store.read("token")}"};
  //Authentication
  static Uri checkToken = Uri.parse("$_authentication/CheckToken");
  static Uri register = Uri.parse("$_authentication/Register");
  static Uri login = Uri.parse("$_authentication/Login");
  static Uri otp = Uri.parse("$_authentication/Otp");
  static Uri revokeToken = Uri.parse("$_authentication/RevokeToken");
  static Uri refreshToken = Uri.parse("$_authentication/RefreshToken");
  static Uri getPrivacy = Uri.parse("$_api/PrivacyPolicy/GetAllPrivacyPolicy");
  static Uri getTermsOfService =
      Uri.parse("$_api/TermsOfService/TermsOfServicGetAll");
  static Uri getStore = Uri.parse("$_api/Store/GetAllStore");
  static Uri getStoreFavorite =
      Uri.parse("$_api/StoreFavorite/GetAllStoreFavorite");
  static Uri getGiftFavorite =
      Uri.parse("$_api/GiftFavorite/GetAllGiftFavorite");
  static Uri addStoreFavorite =
      Uri.parse("$_api/StoreFavorite/CreateStoreFavorite");
  static Uri removeStoreFavorite(String id) =>
      Uri.parse("$_api/StoreFavorite/DeleteStoreFavorite?id=$id");
  static Uri rateStore(String id, double rate) =>
      Uri.parse("$_api/Store/RateStore?id=$id&&rate=$rate");
  static Uri rateGift(String id, double rate) =>
      Uri.parse("$_api/Gift/RateGift?id=$id&&rate=$rate");
  static Uri getNumNotices = Uri.parse("$_api/UserNotices/getNumNotices");
  static Uri getNotices = Uri.parse("$_api/UserNotices/GetNotices");
  static Uri getItemForStore(String id) =>
      Uri.parse("$_api/Gift/GetAllGift?id=$id");
  static Uri addGiftFavorite =
      Uri.parse("$_api/GiftFavorite/CreateGiftFavorite");
  static Uri removeGiftFavorite(String id) =>
      Uri.parse("$_api/GiftFavorite/DeleteGiftFavorite?id=$id");
}

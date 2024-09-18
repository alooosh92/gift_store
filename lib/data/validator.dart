import 'package:get/get.dart';

class ValidatorManager {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "TFCBE".tr;
    }
    //RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    RegExp phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    bool isValidPhone = phoneRegex.hasMatch(email);
    // bool isValidEmail = emailRegex.hasMatch(email);
    if (isValidPhone) {
      return null;
    }
    return "PEAVE".tr;
  }

  static String? textNotEmpty(String? text) {
    if (text == null || text.isEmpty) {
      return "TFCBE".tr;
    }
    return null;
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/models/auth_model.dart';
import 'package:gift_store/data/models/otp_model.dart';
import 'package:gift_store/data/models/register_model.dart';
import 'package:gift_store/data/models/terms_model.dart';
import 'package:gift_store/screen/auth/login/login_screen.dart';
import 'package:gift_store/screen/auth/otp/otp_screen.dart';
import 'package:gift_store/screen/home/home_screen.dart';
import 'package:http/http.dart' as http;
part 'start_state.dart';

class StartCubit extends bloc.Cubit<StartState> {
  String code = "";
  StartCubit() : super(StartInitial());
  void start() async {
    emit(StartInitial());
    var storge = GetStorage();
    String? token = storge.read("token");
    Timer(
      const Duration(seconds: 3),
      () {
        bool otp = storge.read("validOtp") ?? false;
        if (token == null && !otp) {
          emit(LoginFailde());
        } else {
          checkOtp(storge);
        }
      },
    );
  }

  void checkOtp(GetStorage storge) {
    bool? checkOtp = storge.read("validOtp");
    if (checkOtp ?? false) {
      emit(OtpCheck());
    } else {
      checkToken(storge);
    }
  }

  Future<void> checkToken(GetStorage storge) async {
    http.Response response =
        await http.get(Api.checkToken, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      emit(LoginSuccessful());
    } else {
      refreshToken(response, storge);
    }
  }

  Future<void> refreshToken(http.Response response, GetStorage storge) async {
    if (response.statusCode == 401) {
      emit(RefreshToken());
      var storage = GetStorage();
      var rt = storage.read("refreshToken");
      http.Response ref = await http.post(
        Api.refreshToken,
        headers: Api().header(),
        body: jsonEncode(rt),
      );
      if (ref.statusCode == 200) {
        AuthModel auth = AuthModel.fromJson(jsonDecode(ref.body));
        if (auth.isAuthanticated) {
          var storage = GetStorage();
          storage.write("token", auth.token);
          storage.write("refreshToken", auth.refreshToken);
          storage.write("validOtp", false);
          Get.offAll(
            const HomeScreen(),
            transition: Transition.fade,
            duration: const Duration(seconds: 1),
          );
        } else {
          Get.offAll(
            const LoginScreen(),
            transition: Transition.fade,
            duration: const Duration(seconds: 1),
          );
          Get.dialog(AlertDialog(
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("ok".tr))
            ],
            title: Text('note'.tr),
            content: Text("SIOLI".tr),
          ));
        }
      } else {
        Get.offAll(
          const LoginScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
        Get.dialog(AlertDialog(
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("ok".tr))
          ],
          title: Text('note'.tr),
          content: Text("SIOLI".tr),
        ));
      }
    }
  }

  Future<void> loginApi(String phone) async {
    http.Response response = await http.post(
      Api.login,
      headers: Api().header(),
      body: jsonEncode(phone),
    );
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      var storge = GetStorage();
      storge.write("validOtp", true);
      storge.write("phone", phone);
      storge.write("timeOtp", DateTime.now().toString());
      Get.to(
        OTPScreen(username: phone),
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
      );
    } else {
      Get.dialog(const AlertDialog(
        title: Text("تحذير"),
        content: Text("هناك خطأ ما"),
      ));
    }
  }

  Future<void> register(RegisterModel user) async {
    http.Response response = await http.post(
      Api.register,
      headers: Api().header(),
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      var storge = GetStorage();
      storge.write("validOtp", true);
      storge.write("phone", user.phone);
      storge.write("timeOtp", DateTime.now().toString());
      emit(OtpCheck());
      Get.to(
        OTPScreen(username: user.phone),
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
      );
    } else {
      Get.dialog(AlertDialog(
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("موافق"))
        ],
        title: const Text("تحذير"),
        content: const Text("هناك خطأ ما الرجاء التواصل مع المسؤول"),
      ));
    }
  }

  Future<void> otpApi(OtpModel otp) async {
    http.Response response = await http.post(Api.otp,
        headers: Api().header(),
        body: jsonEncode(
          otp.toJson(),
        ));
    if (response.statusCode == 200) {
      AuthModel auth = AuthModel.fromJson(jsonDecode(response.body));
      if (auth.isAuthanticated) {
        var storage = GetStorage();
        storage.write("token", auth.token);
        storage.write("refreshToken", auth.refreshToken);
        storage.write("validOtp", false);
        Get.offAll(
          const HomeScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.dialog(AlertDialog(
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("ok".tr))
          ],
          title: Text('note'.tr),
          content: Text(auth.message ?? "".tr),
        ));
      }
    } else {
      Get.dialog(AlertDialog(
        title: Text("note".tr),
        content: Text("errorAdmin".tr),
      ));
    }
  }

  static Future<List<TermsModel>> getPrivacy() async {
    http.Response response =
        await http.get(Api.getPrivacy, headers: Api().header());
    List<TermsModel> list = [];
    if (response.statusCode == 200) {
      for (var element in jsonDecode(response.body)) {
        list.add(TermsModel.fromJson(element));
      }
    }
    return list;
  }

  static Future<List<TermsModel>> getTermsOfService() async {
    http.Response response =
        await http.get(Api.getTermsOfService, headers: Api().header());
    List<TermsModel> list = [];
    if (response.statusCode == 200) {
      for (var element in jsonDecode(response.body)) {
        list.add(TermsModel.fromJson(element));
      }
    }
    return list;
  }
}

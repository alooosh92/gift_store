import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/otp_model.dart';
import 'package:gift_store/screen/auth/login/login_screen.dart';
import 'package:gift_store/screen/auth/otp/widget/otp_elevated_button.dart';
import 'package:gift_store/screen/auth/widget/row_text_button.dart';

class TimerOtp extends StatefulWidget {
  const TimerOtp({super.key, required this.username});
  final String username;

  @override
  State<TimerOtp> createState() => _TimerOtpState();
}

class _TimerOtpState extends State<TimerOtp> {
  int t = 120;
  int m = 0;
  int s = 0;
  var ss = "00";
  bool first = true;
  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(const Duration(seconds: 1), () {
      if (first) {
        first = false;
        var storge = GetStorage();
        var tn = DateTime.now().difference(DateTime.parse(
            storge.read("timeOtp") ?? DateTime.now().toString()));
        t -= tn.inSeconds;
      }
      if (t > 0) {
        setState(() {
          t--;
          m = t ~/ 60;
          s = t - (t ~/ 60 * 60);
          s < 10 ? ss = "0$s" : ss = "$s";
        });
      }
    });
    return Column(
      children: [
        RowTextButton(
            hintText: "resndHint".tr,
            press: () {
              if (t <= 0) {
                setState(() {
                  bloc.BlocProvider.of<StartCubit>(context)
                      .loginApi(widget.username);
                  t = 120;
                });
              }
            },
            textButton: "resnd".tr),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 10),
            Text("0$m:$ss")
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpElevatedButton(
              color: ColorsManager.primary,
              isLeft: false,
              press: () {
                var code = bloc.BlocProvider.of<StartCubit>(context).code;
                if (code != "" && int.tryParse(code) != null) {
                  timer.cancel();
                  bloc.BlocProvider.of<StartCubit>(context).otpApi(
                      OtpModel(code: int.parse(code), phone: widget.username));
                } else {
                  Get.snackbar("note".tr, "CIUC".tr);
                }
              },
              text: "continue",
              textStyle: FontManager.s18w700cW,
            ),
            OtpElevatedButton(
              color: ColorsManager.darkGray,
              isLeft: true,
              press: () {
                timer.cancel();
                Get.offAll(
                  const LoginScreen(),
                  transition: Transition.fade,
                  duration: const Duration(seconds: 1),
                );
              },
              text: "ChangePhone",
              textStyle: FontManager.s18w700cW,
            ),
          ],
        ),
      ],
    );
  }
}

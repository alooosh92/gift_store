import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/screen/auth/login/login_screen.dart';
import 'package:gift_store/screen/auth/otp/widget/time_otp.dart';
import 'package:gift_store/screen/auth/widget/app_bar_def.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDef("OTP", press: () {
        Get.off(
          const LoginScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'emailVerification'.tr,
                style: FontManager.s32w600cB,
              ),
              Text(
                "emailVerificationBody".tr + username,
                style: FontManager.s14w400cDg,
              ),
              const SizedBox(height: 20),
              OtpTextField(
                keyboardType: TextInputType.number,
                numberOfFields: 6,
                borderRadius: BorderRadius.circular(10),
                textStyle: FontManager.s32w600cB,
                fieldWidth: 50,
                showFieldAsBox: true,
                focusedBorderColor: ColorsManager.primary,
                onSubmit: (value) =>
                    bloc.BlocProvider.of<StartCubit>(context).code = value,
              ),
              const SizedBox(height: 20),
              TimerOtp(
                username: username,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

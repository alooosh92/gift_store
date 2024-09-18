import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/validator.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/auth/register/register_screen.dart';
import 'package:gift_store/screen/auth/widget/elevated_defulte.dart';
import 'package:gift_store/screen/auth/widget/input_text_defulte.dart';
import 'package:gift_store/screen/auth/widget/row_text_button.dart';
import 'package:gift_store/screen/auth/widget/row_text_with_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("$imageLocalPath/logo.png"),
                  InputTextDefulte(
                    text: "EAOPN",
                    hint: "EAOPN",
                    controller: email,
                    texttype: TextInputType.phone,
                    validator: (val) => ValidatorManager.emailValidator(val),
                  ),
                  const SizedBox(height: 30),
                  ElevatedDefulte(
                      color: ColorsManager.primary,
                      widget: Text(
                        "singIn".tr,
                        style: FontManager.s18w700cW,
                      ),
                      press: () {
                        if (formKey.currentState!.validate()) {
                          bloc.BlocProvider.of<StartCubit>(context)
                              .loginApi(email.text);
                        }
                      }),
                  const SizedBox(height: 30),
                  SizedBox(
                    child: Column(
                      children: [
                        RowTextWithDivider(text: "OSIW".tr),
                        const SizedBox(height: 10),
                        RowTextButton(
                          hintText: "noAccont",
                          textButton: "singUp",
                          press: () {
                            Get.to(const RegisterScreen(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

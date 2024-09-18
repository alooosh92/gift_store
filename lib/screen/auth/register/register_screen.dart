import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/validator.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/auth/register/widget/row_policy_check.dart';
import 'package:gift_store/screen/auth/widget/app_bar_def.dart';
import 'package:gift_store/screen/auth/widget/input_text_defulte.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    return Scaffold(
      appBar: appBarDef("singUp".tr),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height -
                  50 -
                  (MediaQuery.paddingOf(context).top +
                      kToolbarHeight +
                      kBottomNavigationBarHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("$imageLocalPath/logo.png"),
                  InputTextDefulte(
                      controller: name,
                      hint: "fullName".tr,
                      text: "enterName".tr,
                      validator: (val) => ValidatorManager.textNotEmpty(val),
                      texttype: TextInputType.text),
                  InputTextDefulte(
                      controller: phone,
                      hint: "EAOPN".tr,
                      text: "EAOPN".tr,
                      validator: (email) =>
                          ValidatorManager.emailValidator(email),
                      texttype: TextInputType.phone),
                  RowPolicyCheck(
                    formKey: formKey,
                    name: name,
                    phone: phone,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/register_model.dart';
import 'package:gift_store/screen/auth/privacy_policy/privacy_policy.dart';
import 'package:gift_store/screen/auth/terms_of_service/terms_of_service.dart';
import 'package:gift_store/screen/auth/widget/elevated_defulte.dart';
import 'package:gift_store/screen/auth/widget/row_text_button.dart';

class RowPolicyCheck extends StatefulWidget {
  const RowPolicyCheck({
    super.key,
    required this.formKey,
    required this.name,
    required this.phone,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController phone;
  @override
  State<RowPolicyCheck> createState() => _RowPolicyCheckState();
}

class _RowPolicyCheckState extends State<RowPolicyCheck> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: check,
              onChanged: (val) => setState(() {
                check = val!;
              }),
              activeColor: ColorsManager.primary,
            ),
            RowTextButton(
                hintText: "agree".tr,
                press: () => Get.to(const TermsOfServiceScreen(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1)),
                textButton: "terms".tr),
            RowTextButton(
                hintText: "and".tr,
                press: () => Get.to(const PrivacyPolicyScreen(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1)),
                textButton: "policy".tr),
          ],
        ),
        ElevatedDefulte(
          color: ColorsManager.primary,
          widget: Text(
            "singUp".tr,
            style: FontManager.s18w700cW,
          ),
          press: !check
              ? null
              : () {
                  if (widget.formKey.currentState!.validate()) {
                    bloc.BlocProvider.of<StartCubit>(context)
                        .register(RegisterModel(
                      fullName: widget.name.text,
                      phone: widget.phone.text,
                    ));
                  }
                },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/screen/auth/widget/body_terms_and_privacy.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyTermsAndPrivacy(
      textAppBar: "terms",
      future: StartCubit.getTermsOfService(),
    );
  }
}

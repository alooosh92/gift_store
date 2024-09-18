import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/colors.dart';

Future<dynamic> dialogProgress() {
  return Get.dialog(const DialogProgress());
}

class DialogProgress extends StatelessWidget {
  const DialogProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsManager.primary,
      ),
    );
  }
}

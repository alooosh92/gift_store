import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/colors.dart';

Future<dynamic> dialogProgress() {
  return Get.dialog(const Center(
    child: CircularProgressIndicator(
      color: ColorsManager.primary,
    ),
  ));
}

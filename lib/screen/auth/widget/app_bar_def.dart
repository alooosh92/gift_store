import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';

AppBar appBarDef(String text, {double? elevation, Function()? press}) {
  return AppBar(
    centerTitle: true,
    shadowColor: ColorsManager.gray,
    toolbarHeight: 100,
    elevation: elevation ?? 5,
    leading: IconButton(
        onPressed: () => press ?? Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorsManager.primary,
        )),
    title: Text(
      text.tr,
      style: FontManager.s20w700cB,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gift_store/data/colors.dart';

class ThemeService {
  final darkMode = ThemeData.dark().copyWith(
    textTheme: Typography().white.apply(fontFamily: 'Lato'),
  );
  final lightTheme = ThemeData.light().copyWith(
      textTheme: Typography().black.apply(fontFamily: 'Lato'),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsManager.white,
        surfaceTintColor: ColorsManager.white,
      ));
  static bool isLightTheme() {
    var storage = GetStorage();
    bool? theme = storage.read("theme");
    if (theme != null) return theme;
    var themeMode = ThemeMode.system;
    if (themeMode == ThemeMode.light) return true;
    return false;
  }
}

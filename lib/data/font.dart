import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gift_store/data/colors.dart';

class FontManager {
  static TextStyle ts(double size, FontWeight weight, Color? color) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color);
  }

  static TextStyle s14w500cDb = ts(14, FontWeight.w500, null);
  static TextStyle s14w500cP = ts(14, FontWeight.w500, ColorsManager.primary);
  static TextStyle s18w700cW = ts(18, FontWeight.w700, ColorsManager.white);
  static TextStyle s16w400cDg = ts(16, FontWeight.w400, ColorsManager.darkGray);
  static TextStyle s20w700cB = ts(20, FontWeight.w700, null);
  static TextStyle s14w700cB = ts(14, FontWeight.w700, null);
  static TextStyle s14w500cB = ts(14, FontWeight.w500, null);
  static TextStyle s32w600cB = ts(32, FontWeight.w600, ColorsManager.black);
  static TextStyle s14w400cDg = ts(14, FontWeight.w400, ColorsManager.darkGray);
  static TextStyle s16w700cB = ts(16, FontWeight.w700, ColorsManager.black);
  static TextStyle s16w700cP = ts(16, FontWeight.w700, ColorsManager.primary);
  static TextStyle s14w600cR = ts(14, FontWeight.w600, ColorsManager.red);
  // static TextStyle s14w700cP = ts(14, FontWeight.w700, ColorsManager.primary);
  // static TextStyle s20w600cB = ts(20, FontWeight.w600, ColorsManager.black);
  // static TextStyle s12w400cG = ts(14, FontWeight.w400, ColorsManager.gray);
  // static TextStyle s16w500cB = ts(16, FontWeight.w500, null);
  // static TextStyle s16w700cW = ts(16, FontWeight.w700, ColorsManager.white);
  // static TextStyle s18w400cB = ts(18, FontWeight.w400, null);
  // static TextStyle s32w800cW = ts(32, FontWeight.w800, ColorsManager.white);
  // static TextStyle s16w400cBr = ts(16, FontWeight.w400, ColorsManager.brown);
  // static TextStyle s18w700cB = ts(18, FontWeight.w700, ColorsManager.black);
}

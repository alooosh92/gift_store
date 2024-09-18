import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translation_manager.dart';

class LocalizationsManager {
  static Translations translations = TranslationManager();
  static Locale locale = const Locale('ar');
  static Locale fallbackLocale = const Locale('en');
  static const Transition defaultTransition = Transition.fade;
  static const Iterable<Locale> supportedLocales = [Locale('ar'), Locale('en')];
  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static void getLangValue() async {
    var shared = GetStorage();
    var l = shared.read('lang');
    if (l == null || l.isEmpty) {
      locale = localeResolutionCallback(Get.deviceLocale, supportedLocales);
      shared.write('lang', locale.languageCode);
    } else {
      if (l == 'ar') {
        locale = const Locale('ar');
        fallbackLocale = const Locale('en');
        shared.write('lang', 'ar');
      } else {
        locale = const Locale('en');
        fallbackLocale = const Locale('ar');
        shared.write('lang', 'en');
      }
    }
  }

  static void setLangValue(String lang) async {
    var shared = GetStorage();
    shared.write('lang', lang);
  }

  static Locale localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale != null && supportedLocales.contains(locale)) {
      return locale;
    }
    return const Locale('ar');
  }
}

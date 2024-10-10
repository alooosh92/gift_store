import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/locale-master/localizations_manager.dart';
import 'package:gift_store/data/theme_service.dart';
import 'package:gift_store/screen/auth/start/start_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartCubit>(
          create: (context) => StartCubit()..start(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<StoreCubit>(
          create: (context) => StoreCubit(),
        )
      ],
      child: GetMaterialApp(
        themeMode:
            ThemeService.isLightTheme() ? ThemeMode.light : ThemeMode.dark,
        darkTheme: ThemeService().darkMode,
        debugShowCheckedModeBanner: false,
        theme: ThemeService().lightTheme,
        locale: LocalizationsManager.locale,
        translations: LocalizationsManager.translations,
        fallbackLocale: LocalizationsManager.fallbackLocale,
        defaultTransition: LocalizationsManager.defaultTransition,
        supportedLocales: LocalizationsManager.supportedLocales,
        localizationsDelegates: LocalizationsManager.localizationsDelegates,
        home: const StartScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gift_store/controller/start_cubit/start_cubit.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/auth/login/login_screen.dart';
import 'package:gift_store/screen/auth/otp/otp_screen.dart';
import 'package:gift_store/screen/auth/register/register_screen.dart';
import 'package:gift_store/screen/home/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartCubit, StartState>(
      builder: (context, state) {
        switch (state) {
          case LoginFailde():
            {
              return const LoginScreen();
            }
          case LoginSuccessful():
            {
              return const HomeScreen();
            }
          case OtpCheck():
            {
              var storge = GetStorage();
              return OTPScreen(
                username: storge.read("phone"),
              );
            }
          case Register():
            {
              return const RegisterScreen();
            }
          default:
            {
              return Scaffold(
                body: Center(
                  child: Image.asset("$imageLocalPath/logo.png"),
                ),
              );
            }
        }
      },
    );
  }
}

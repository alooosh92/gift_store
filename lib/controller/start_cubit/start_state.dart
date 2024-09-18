part of 'start_cubit.dart';

@immutable
sealed class StartState {}

final class StartInitial extends StartState {}

final class TokenChecked extends StartState {}

final class RefreshToken extends StartState {}

final class LoginSuccessful extends StartState {}

final class LoginWithoutValid extends StartState {}

final class LoginFailde extends StartState {}

final class RegisterSuccessful extends StartState {}

final class OtpCheck extends StartState {}

final class OtpSuccessful extends StartState {}

final class Register extends StartState {}

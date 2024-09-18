part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChoeseGategore extends HomeState {}

final class LodeingData extends HomeState {}

final class DataReady extends HomeState {}

final class FaildGetData extends HomeState {}

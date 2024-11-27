part of 'store_cubit.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class StoreLoding extends StoreState {}

final class Storefield extends StoreState {}

final class StoreReady extends StoreState {}

final class StoreChangeLocal extends StoreState {}

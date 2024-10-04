import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());
  int itemChase = -1;
  void changeItem(int i) {
    if (i == itemChase) {
      itemChase = -1;
    } else {
      itemChase = i;
    }
    emit(StoreReady());
  }

  Future<void> getItem() async {}
}

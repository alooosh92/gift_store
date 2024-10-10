import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/favorite_model.dart';
import 'package:gift_store/data/models/gift_model.dart';
import 'package:gift_store/screen/widget/dialog_progress.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());
  int itemChase = -1;
  List<GiftModel> giftList = [];
  List<FavoriteModel> listGiftFavorite = [];
  void changeItem(int i) {
    if (i == itemChase) {
      itemChase = -1;
    } else {
      itemChase = i;
    }
    emit(StoreReady());
  }

  Future<void> getItem(String id) async {
    List<GiftModel> list = [];
    http.Response response = await http.get(Api.getItemForStore(id),
        headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        list.add(GiftModel.fromJson(element));
      }
      giftList = list;
      await getFavorite();
    }
    emit(StoreReady());
  }

  Future<void> getFavorite() async {
    http.Response response =
        await http.get(Api.getGiftFavorite, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        listGiftFavorite.add(FavoriteModel.fromJson(element, 'gift'));
      }
    }
  }

  void addGiftToFavorite(String id) async {
    dialogProgress();
    var body = jsonEncode(id);
    http.Response response = await http.post(Api.addGiftFavorite,
        headers: Api().headerWithToken(), body: body);
    if (response.statusCode == 200) {
      var bo = FavoriteModel.fromJson(jsonDecode(response.body), 'gift');
      listGiftFavorite.add(FavoriteModel(id: bo.id, store: id));
      var fav = giftList.where((element) => element.id == id).firstOrNull;
      if (fav != null) {
        fav.favorate = true;
        fav.favorateId = bo.id;
      }
      emit(StoreReady());
    }
    Get.back();
    Get.snackbar('ملاحظة', 'تمت الاضافة الى المفضلة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorsManager.primary,
        colorText: ColorsManager.black);
  }

  void removeGiftFromFavorite(String id) async {
    dialogProgress();
    http.Response response = await http.delete(Api.removeGiftFavorite(id),
        headers: Api().headerWithToken());
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      listGiftFavorite.removeWhere(
        (element) => element.id == id,
      );
      var fav =
          giftList.where((element) => element.favorateId == id).firstOrNull;
      if (fav != null) {
        fav.favorate = null;
        fav.favorateId = null;
      }
      emit(StoreReady());
    }
    Get.back();
    Get.snackbar('ملاحظة', 'تمت الحذف من المفضلة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorsManager.primary,
        colorText: ColorsManager.black);
  }

  void rateGift(String id, double rate) async {
    dialogProgress();
    http.Response response = await http.get(Api.rateGift(id, rate),
        headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var gift = giftList.where((element) => element.id == id).first;
      gift.rate = double.parse(jsonDecode(response.body).toString());
      Get.back();
      Get.back();
      emit(StoreReady());
    } else {
      Get.back();
      Get.snackbar("تحذير", "هناك خطأ ما الرجاء المحاولة لاحقاً");
    }
  }
}

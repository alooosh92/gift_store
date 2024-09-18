import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/models/favorite_store_model.dart';
import 'package:gift_store/data/models/notices_model.dart';
import 'package:gift_store/data/models/store_model.dart';
import 'package:gift_store/screen/widget/dialog_progress.dart';
import 'package:http/http.dart' as http;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int category = 0;
  int numNotices = 0;
  int region = 0;
  String searchBar = "";
  List<StoreModel> allStore = [];
  List<StoreModel> searchStore = [];
  List<String> regions = ["الكل"];
  List<String> listCategore = ["الكل"];
  List<FavoriteStoreModel> listStoreFavorite = [];

  void changeTextSearchBar(String val) {
    searchBar = val;
    if (category == 0 && searchBar == "" && region == 0) {
      searchStore = allStore;
    } else {
      searchStore = allStore.where((element) {
        var c = category != 0 ? element.type == listCategore[category] : true;
        var r = region != 0 ? element.region == regions[region] : true;
        var s = element.description.contains(searchBar) ||
            element.name.contains(searchBar);
        return c && r && s;
      }).toList();
    }
    emit(ChoeseGategore());
  }

  void changeRegion(int index) {
    region = index;
    if (category == 0 && searchBar == "" && region == 0) {
      searchStore = allStore;
    } else {
      searchStore = allStore.where((element) {
        var c = category != 0 ? element.type == listCategore[category] : true;
        var r = region != 0 ? element.region == regions[region] : true;
        var s = element.description.contains(searchBar) ||
            element.name.contains(searchBar);
        return c && r && s;
      }).toList();
    }
    emit(ChoeseGategore());
  }

  void changeCategore(int index) {
    category = index;
    if (category == 0 && searchBar == "" && region == 0) {
      searchStore = allStore;
    } else {
      searchStore = allStore.where((element) {
        var c = category != 0 ? element.type == listCategore[category] : true;
        var r = region != 0 ? element.region == regions[region] : true;
        var s = element.description.contains(searchBar) ||
            element.name.contains(searchBar);
        return c && r && s;
      }).toList();
    }
    emit(ChoeseGategore());
  }

  void getStore() async {
    emit(LodeingData());
    getStoreFavorite();
    getNumNotices(true);
    allStore = [];
    http.Response response =
        await http.get(Api.getStore, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        StoreModel store = StoreModel.fromJson(element);
        var fav = listStoreFavorite
            .where((element) => element.store == store.id)
            .firstOrNull;
        if (fav != null) {
          store.favorate = true;
          store.favorateId = fav.id;
        }

        allStore.add(store);
        regions.addIf(
            !regions.any(
              (element) => element == store.region,
            ),
            store.region);
        listCategore.addIf(
            !listCategore.any(
              (element) => element == store.type,
            ),
            store.type);
      }
      searchStore = allStore;
      emit(DataReady());
    } else {
      emit(FaildGetData());
    }
  }

  void getStoreFavorite() async {
    http.Response response =
        await http.get(Api.getStoreFavorite, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        listStoreFavorite.add(FavoriteStoreModel.fromJson(element));
      }
    }
  }

  void addStoreToFavorite(String id) async {
    dialogProgress();
    var body = jsonEncode(id);
    http.Response response = await http.post(Api.addStoreFavorite,
        headers: Api().headerWithToken(), body: body);
    if (response.statusCode == 200) {
      var bo = FavoriteStoreModel.fromJson(jsonDecode(response.body));
      listStoreFavorite.add(FavoriteStoreModel(id: bo.id, store: id));
      var fav = allStore.where((element) => element.id == id).firstOrNull;
      if (fav != null) {
        fav.favorate = true;
        fav.favorateId = bo.id;
      }
      var favs = searchStore.where((element) => element.id == id).firstOrNull;
      if (favs != null) {
        favs.favorate = true;
        favs.favorateId = bo.id;
      }
      emit(DataReady());
    }
    Get.back();
  }

  void removeStoreFromFavorite(String id) async {
    dialogProgress();
    http.Response response = await http.delete(Api.removeStoreFavorite(id),
        headers: Api().headerWithToken());
    if (response.statusCode == 200 && jsonDecode(response.body)) {
      listStoreFavorite.removeWhere(
        (element) => element.id == id,
      );
      var fav =
          allStore.where((element) => element.favorateId == id).firstOrNull;
      if (fav != null) {
        fav.favorate = null;
        fav.favorateId = null;
      }
      var favs =
          searchStore.where((element) => element.favorateId == id).firstOrNull;
      if (favs != null) {
        favs.favorate = null;
        favs.favorateId = null;
      }
      emit(DataReady());
    }
    Get.back();
  }

  void rateStore(String id, double rate) async {
    dialogProgress();
    http.Response response = await http.get(Api.rateStore(id, rate),
        headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var stor = allStore.where((element) => element.id == id).first;
      stor.rate = double.parse(jsonDecode(response.body).toString());
      var sstor = searchStore.where((element) => element.id == id).first;
      sstor.rate = double.parse(jsonDecode(response.body).toString());
      Get.back();
      Get.back();
      emit(DataReady());
    } else {
      Get.back();
      Get.snackbar("تحذير", "هناك خطأ ما الرجاء المحاولة لاحقاً");
    }
  }

  void getNumNotices(bool isStart) async {
    http.Response response =
        await http.get(Api.getNumNotices, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      numNotices = jsonDecode(response.body);
      isStart ? emit(DataReady()) : null;
    }
  }

  Future<List<NoticesModel>> getNotices() async {
    List<NoticesModel> list = [];
    http.Response response =
        await http.get(Api.getNotices, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        list.add(NoticesModel.fromJson(element));
      }
      getNumNotices(false);
      emit(DataReady());
    }
    return list;
  }
}

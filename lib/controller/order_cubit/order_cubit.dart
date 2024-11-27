import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/screen/widget/dialog_progress.dart';
import 'package:http/http.dart' as http;
import '../../data/models/view_order_model.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<ViewOrderModel> list = [];
  OrderCubit() : super(OrderInitial());
  Future<void> getAllOrder() async {
    http.Response response =
        await http.get(Api.getAllOrder, headers: Api().headerWithToken());
    if (response.statusCode == 200) {
      list = [];
      var body = jsonDecode(response.body);
      for (var element in body) {
        list.add(ViewOrderModel.fromJson(element));
      }
    }
  }

  void approvalOrder(String id) {
    Get.dialog(AlertDialog(
      actions: [
        TextButton(
            onPressed: () async {
              dialogProgress();
              http.Response response = await http.put(Api.approvalOrder(id),
                  headers: Api().headerWithToken());
              if (response.statusCode == 200) {
                bool body = jsonDecode(response.body);
                if (body) {
                  list.where((a) => a.id == id).singleOrNull?.orderStatus =
                      "AppRoval";
                  Get.back();
                  Get.back();
                  emit(OrderReady());
                }
              }
            },
            child: const Text('موافق')),
        TextButton(onPressed: () => Get.back(), child: const Text('إلغاء'))
      ],
      title: const Text('تأكيد الطلبية'),
      content: const Text(
          'تأكيد الطلب؟\nبحال تأكيد الطلب والموافقة على الطلب من المتجر لا يمكن الغاء الطلب'),
    ));
  }
}

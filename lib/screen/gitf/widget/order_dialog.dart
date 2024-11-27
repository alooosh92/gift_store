import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/order_model.dart';
import 'package:gift_store/screen/gitf/widget/add_item_dialog.dart';
import 'package:gift_store/screen/gitf/widget/map_dialog.dart';
import 'package:gift_store/screen/gitf/widget/text_field_def.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({super.key, required this.storeId, required this.itemId});
  final String storeId;
  final String itemId;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController note = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      elevation: 3,
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              OrderModel orderModel = OrderModel(
                  late: BlocProvider.of<StoreCubit>(context).local!.latitude,
                  long: BlocProvider.of<StoreCubit>(context).local!.longitude,
                  address: address.text,
                  name: name.text,
                  notes: note.text,
                  phone: phone.text,
                  store: storeId);
              String? res = await BlocProvider.of<StoreCubit>(context)
                  .addOrder(orderModel);
              if (res != null) {
                Get.back();
                Get.dialog(AddItemDialog(
                  orderId: res,
                  itemId: itemId,
                ));
              } else {
                Get.snackbar('خطأ', 'هناك خطأ ما الرجاء الاتصال بالمسؤول');
              }
            }
          },
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ColorsManager.primary)),
          child: const Text("انشاء طلبية"),
        ),
        ElevatedButton(
            onPressed: () => Get.back(),
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(ColorsManager.red)),
            child: const Text(
              "إلغاء",
              style: TextStyle(color: ColorsManager.white),
            )),
      ],
      title: const Column(
        children: [
          Text('انشاء طلبية'),
          Divider(),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MapDialog(),
              TextFieldDef(name: name, label: 'اسم المستلم'),
              TextFieldDef(name: phone, label: 'رقم هاتف المستلم'),
              TextFieldDef(name: address, label: 'العنوان بالتفصيل', lines: 2),
              TextFieldDef(name: note, label: 'ملاحظات', validator: false),
            ],
          ),
        ),
      ),
    );
  }
}

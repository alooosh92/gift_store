import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/item_model.dart';
import 'package:gift_store/screen/gitf/widget/text_field_def.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({
    super.key,
    required this.itemId,
    required this.orderId,
  });
  final String orderId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    TextEditingController number = TextEditingController(text: "1");
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      elevation: 3,
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate() &&
                int.tryParse(number.text) != null) {
              ItemModel itemModel = ItemModel(
                  giftId: itemId,
                  number: int.parse(number.text),
                  orderId: orderId);
              bool res =
                  await BlocProvider.of<StoreCubit>(context).addItem(itemModel);
              if (res) {
                Get.back();
                Get.snackbar('ملاحظة', 'تم اضافة العنصر');
              } else {
                Get.snackbar('خطأ', 'يوجد خطأ الرجاء الاتصال بالمسؤول');
              }
            }
          },
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ColorsManager.primary)),
          child: const Text("إضافة"),
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
          Text("اضافة الى السلة"),
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
              TextFieldDef(
                name: number,
                label: 'العدد',
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/screen/gitf/widget/add_item_dialog.dart';
import 'package:gift_store/screen/gitf/widget/order_dialog.dart';

class AddToBassket extends StatelessWidget {
  const AddToBassket({super.key, required this.storeId, required this.itemId});
  final String storeId;
  final String itemId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String? orderState =
            await BlocProvider.of<StoreCubit>(context).openOrder();
        if (orderState == null) {
          if (context.mounted) {
            BlocProvider.of<StoreCubit>(context).local = null;
            Get.dialog(OrderDialog(
              storeId: storeId,
              itemId: itemId,
            ));
          }
        } else {
          Get.dialog(AddItemDialog(
            orderId: orderState,
            itemId: itemId,
          ));
        }
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.55,
        height: 50,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: ColorsManager.gray,
                offset: Offset(-2, 2),
              )
            ],
            color: ColorsManager.primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Center(
          child: Text(
            'إضافة الى السلة',
            style: FontManager.s16w700cB,
          ),
        ),
      ),
    );
  }
}

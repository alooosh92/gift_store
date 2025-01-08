import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/order_cubit/order_cubit.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/view_order_model.dart';
import 'package:gift_store/screen/widget/dialog_progress.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلباتي"),
      ),
      body: FutureBuilder(
        future: BlocProvider.of<OrderCubit>(context).getAllOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DialogProgress();
          }
          if (BlocProvider.of<OrderCubit>(context).list.isEmpty) {
            return const Center(
              child: Text("لا يوجد طلبيات لعرضها"),
            );
          }
          return const OrderBody();
        },
      ),
    );
  }
}

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        List<ViewOrderModel> list = BlocProvider.of<OrderCubit>(context).list;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            ViewOrderModel order = list[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: ColorsManager.white,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, offset: Offset(2, 2))
                  ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: ColorsManager.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'اسم المتجر: ${order.storeName}',
                          style: FontManager.s16w700cB,
                        ),
                        Text(
                          'الحالة: ${order.orderStatus.tr}',
                          style: FontManager.s16w700cB,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                                'تاريخ الإنشاء: ${dateFormat.format(order.createDate)}'),
                            Text('اسم المستفيد: ${order.toName}'),
                            Text('هاتف المستفيد: ${order.toPhone}'),
                            Text('الاجمالي:  ${order.totalPrice.toInt()}'),
                            Text('الخصم:  ${order.offer.toInt()}'),
                            Text(
                                ' السعر:  ${(order.totalPrice - order.offer).toInt()}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).width / 2 - 75,
                              width: MediaQuery.sizeOf(context).width / 2 - 75,
                              child: CachedNetworkImage(
                                imageUrl: '${Api.storeImage}/${order.url}',
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  RowButtonAppRoval(order: order),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class RowButtonAppRoval extends StatelessWidget {
  const RowButtonAppRoval({
    super.key,
    required this.order,
  });

  final ViewOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: order.orderStatus == "NewCreate",
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorsManager.primary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))))),
                onPressed: () {
                  BlocProvider.of<OrderCubit>(context).approvalOrder(order.id);
                },
                child: const Text('تأكيد الطلبية')),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(ColorsManager.red),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))))),
                onPressed: () {},
                child: const Text(
                  'إلغاء الطلبية',
                  style: TextStyle(color: ColorsManager.white),
                ))
          ],
        ),
      ),
    );
  }
}

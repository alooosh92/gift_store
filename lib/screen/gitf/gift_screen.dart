import 'package:flutter/material.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/gift_model.dart';
import 'package:gift_store/screen/gitf/widget/favorite_button.dart';
import 'package:gift_store/screen/gitf/widget/image_page_gift_screen.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key, required this.giftModel});
  final GiftModel giftModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ImagePageGiftScreen(giftModel: giftModel),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height - 450,
              child: SingleChildScrollView(
                child: Text(
                  giftModel.description,
                  style: FontManager.s16w700cB,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavoriteButton(id: giftModel.id),
              InkWell(
                onTap: () {},
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
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Center(
                    child: Text(
                      'إضافة الى السلة',
                      style: FontManager.s16w700cB,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

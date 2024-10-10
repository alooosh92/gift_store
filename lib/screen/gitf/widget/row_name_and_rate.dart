import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/gift_model.dart';
import 'package:gift_store/screen/widget/ratestart_button.dart';

class RowNameAndRate extends StatelessWidget {
  const RowNameAndRate({
    super.key,
    required this.giftModel,
  });

  final GiftModel giftModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 260,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const FaIcon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: Text(
                          giftModel.name,
                          style: FontManager.s22w700cB,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  RateStartButton(
                    id: giftModel.id,
                    isStore: true,
                    numRate: giftModel.numRate,
                    start: giftModel.rate,
                  )
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

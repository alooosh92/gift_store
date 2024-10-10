import 'package:flutter/material.dart';
import 'package:gift_store/data/models/gift_model.dart';
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
        ],
      ),
    );
  }
}

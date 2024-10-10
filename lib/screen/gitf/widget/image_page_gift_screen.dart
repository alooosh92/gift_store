import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/gift_model.dart';
import 'package:gift_store/screen/gitf/widget/row_name_and_rate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagePageGiftScreen extends StatefulWidget {
  const ImagePageGiftScreen({super.key, required this.giftModel});
  final GiftModel giftModel;
  @override
  State<ImagePageGiftScreen> createState() => _ImagePageGiftScreenState();
}

class _ImagePageGiftScreenState extends State<ImagePageGiftScreen> {
  PageController pageController = PageController(initialPage: 0);
  Timer? timer;
  int i = 0;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (time) {
      if (i > widget.giftModel.giftImages.length - 1) {
        i = 0;
      }
      pageController.animateToPage(i,
          duration: const Duration(seconds: 1), curve: Curves.linear);
      i++;
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 325,
      child: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: widget.giftModel.giftImages.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl:
                    "${Api.storeGift}/${widget.giftModel.giftImages[index].url}",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 275,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.fill,
              );
            },
          ),
          Positioned(
            bottom: 75,
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: widget.giftModel.giftImages.length,
                  effect: const WormEffect(
                      dotColor: ColorsManager.darkGray,
                      activeDotColor: ColorsManager.primary),
                ),
              ],
            ),
          ),
          RowNameAndRate(giftModel: widget.giftModel),
        ],
      ),
    );
  }
}

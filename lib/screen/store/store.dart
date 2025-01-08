import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/store_model.dart';
import 'package:gift_store/screen/store/widget/bottom_navigation_bar_store.dart';
import 'package:gift_store/screen/store/widget/store_home.dart';
import 'package:gift_store/screen/store/widget/store_offers.dart';
import 'package:gift_store/screen/widget/ratestart_button.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key, required this.store});
  final StoreModel store;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarStore(),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "${Api.storeImage}/${store.listImage.where((element) => element.type == "Icon").firstOrNull!.url}",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 275,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height -
                    260 -
                    kBottomNavigationBarHeight,
                decoration: const BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
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
                                  store.name,
                                  style: FontManager.s22w700cB,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          RateStartButton(
                            id: store.id,
                            isStore: true,
                            numRate: store.numRate,
                            start: store.rate,
                          )
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height -
                              kBottomNavigationBarHeight -
                              340,
                          child: BlocBuilder<StoreCubit, StoreState>(
                            builder: (context, state) {
                              return PageView.builder(
                                controller: BlocProvider.of<StoreCubit>(context)
                                    .pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pages(store).length,
                                itemBuilder: (context, index) {
                                  return pages(store)[index];
                                },
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> pages(StoreModel store) => [
      StoreHome(store: store),
      StoreOffers(id: store.id),
      Container(),
    ];

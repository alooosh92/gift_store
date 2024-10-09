import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/gift_model.dart';
import 'package:gift_store/data/models/store_model.dart';
import 'package:gift_store/screen/store/widget/bottom_navigation_bar_store.dart';
import 'package:gift_store/screen/widget/ratestart_button.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key, required this.store});
  final StoreModel store;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(),
      child: Scaffold(
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
                          child: PageView.builder(
                            itemCount: pages(store).length,
                            itemBuilder: (context, index) {
                              return pages(store)[index];
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> pages(StoreModel store) => [
      StoreHome(store: store),
      Container(),
      Container(),
    ];

class StoreHome extends StatelessWidget {
  const StoreHome({super.key, required this.store});
  final StoreModel store;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.sizeOf(context).width / 2 - 20 > 200
        ? 200
        : MediaQuery.sizeOf(context).width / 2 - 20;
    return FutureBuilder(
        future: BlocProvider.of<StoreCubit>(context).getItem(store.id),
        builder: (context, snapshot) {
          return BlocBuilder<StoreCubit, StoreState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: BlocProvider.of<StoreCubit>(context).giftList.length,
                itemBuilder: (context, index) {
                  GiftModel gift =
                      BlocProvider.of<StoreCubit>(context).giftList[index];
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<StoreCubit>(context).changeItem(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: size,
                          width: size,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  '${Api.storeGift}/${gift.giftImages.where((element) => element.type == "Icon").firstOrNull?.url}',
                                  errorListener: (p0) =>
                                      const Icon(Icons.error),
                                  cacheManager: CachedNetworkImageProvider
                                      .defaultCacheManager),
                            ),
                          ),
                          child: Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: BlocProvider.of<StoreCubit>(context)
                                    .itemChase !=
                                index,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: BlocProvider.of<StoreCubit>(context)
                                          .itemChase !=
                                      index
                                  ? 1
                                  : 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 25,
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(123, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () => gift.favorate ?? false
                                              ? BlocProvider.of<StoreCubit>(
                                                      context)
                                                  .removeGiftFromFavorite(
                                                      gift.favorateId!)
                                              : BlocProvider.of<StoreCubit>(
                                                      context)
                                                  .addGiftToFavorite(gift.id),
                                          child: gift.favorate ?? false
                                              ? const FaIcon(
                                                  FontAwesomeIcons.solidHeart,
                                                  color: ColorsManager.red,
                                                )
                                              : const FaIcon(
                                                  FontAwesomeIcons.heart,
                                                  color: ColorsManager.red,
                                                ),
                                        ),
                                        RateStartButton(
                                          id: gift.id,
                                          isStore: false,
                                          numRate: gift.numRate,
                                          start: gift.rate,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible:
                              BlocProvider.of<StoreCubit>(context).itemChase ==
                                  index,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: BlocProvider.of<StoreCubit>(context)
                                        .itemChase ==
                                    index
                                ? 1
                                : 0,
                            child: Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(200, 255, 255, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      gift.name,
                                      style: FontManager.s18w700cB,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Text(
                                        gift.miniDescription,
                                        style: FontManager.s16w700cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          shadowColor: WidgetStatePropertyAll(
                                              Colors.transparent),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.transparent)),
                                      onPressed: () {},
                                      child: Image.asset(
                                        'asset/images/nextIcon.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        });
  }
}

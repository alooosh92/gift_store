import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/store_model.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/about_us/about_us.dart';
import 'package:gift_store/screen/home/widget/app_bar_home.dart';
import 'package:rate/rate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarHome(context, scaffoldKey),
      body: const HomeBody(),
      drawer: const DrawerWedget(),
    );
  }
}

class DrawerWedget extends StatelessWidget {
  const DrawerWedget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset("$imageLocalPath/logo.png"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerItem(text: "الملف الشخصي", press: () {}),
              DrawerItem(text: "طلباتي", press: () {}),
              DrawerItem(text: "سياسة الخصوصية", press: () {}),
              DrawerItem(text: "شروط الاستخدام", press: () {}),
              DrawerItem(
                  text: "من نحن",
                  press: () {
                    Get.to(const AboutUsScreen());
                  }),
              DrawerItem(
                  text: "تسجيل خروج", press: () {}, withOutDivider: true),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حقوق النشر محفوظة لشركة AloshCo'),
              SizedBox(width: 5),
              FaIcon(FontAwesomeIcons.copyright, size: 12),
            ],
          )
        ],
      )),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.press,
    required this.text,
    this.withOutDivider,
  });
  final String text;
  final Function() press;
  final bool? withOutDivider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Text(text),
          withOutDivider ?? false ? const SizedBox() : const Divider(),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).getStore();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "المتاجر",
                  style: FontManager.s14w500cB,
                )
              ],
            ),
            SizedBox(
                height:
                    MediaQuery.sizeOf(context).height - kToolbarHeight - 220,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state) {
                      case LodeingData():
                        return const Center(child: CircularProgressIndicator());
                      case DataReady() || ChoeseGategore():
                        return ListView.builder(
                          itemCount: BlocProvider.of<HomeCubit>(context)
                              .searchStore
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return StoreWidget(
                              store: BlocProvider.of<HomeCubit>(context)
                                  .searchStore[index],
                            );
                          },
                        );
                      case FaildGetData():
                        return const Center(
                            child: Text("لا يوجد بيانات لعرضها"));
                      default:
                        return const Center(child: CircularProgressIndicator());
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class StoreWidget extends StatelessWidget {
  const StoreWidget({super.key, required this.store});
  final StoreModel store;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          offset: Offset(1, 1),
                          blurStyle: BlurStyle.solid),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsManager.white),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "${Api.storeImage}/${store.listImage.where((element) => element.type == "Icon").firstOrNull!.url}",
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => store.favorate ?? false
                                ? BlocProvider.of<HomeCubit>(context)
                                    .removeStoreFromFavorite(store.favorateId!)
                                : BlocProvider.of<HomeCubit>(context)
                                    .addStoreToFavorite(store.id),
                            child: store.favorate ?? false
                                ? const FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: ColorsManager.red,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: ColorsManager.red,
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              double rate = 0;
                              Get.dialog(AlertDialog(
                                alignment: Alignment.center,
                                actions: [
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        "إلغاء",
                                        style: FontManager.s16w700cB,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        BlocProvider.of<HomeCubit>(context)
                                            .rateStore(store.id, rate);
                                      },
                                      child: Text(
                                        "تقييم",
                                        style: FontManager.s16w700cP,
                                      ))
                                ],
                                title: const Text('تقييم'),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Rate(
                                      iconSize: 40,
                                      color: ColorsManager.primary,
                                      allowHalf: true,
                                      allowClear: true,
                                      initialValue: rate,
                                      readOnly: false,
                                      onChange: (value) => rate = value,
                                    ),
                                  ],
                                ),
                              ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  " (${store.numRate.toInt()}) ",
                                  style: FontManager.s14w400cDg,
                                ),
                                SizedBox(
                                  height: 20,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: store.rate.round() == 0
                                        ? 1
                                        : store.rate.round(),
                                    itemBuilder: (context, index) => FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: store.rate.toInt() != 0
                                          ? ColorsManager.primary
                                          : ColorsManager.whiteDark1,
                                      size: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/api.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/store_model.dart';
import 'package:gift_store/screen/store/store.dart';
import 'package:gift_store/screen/widget/ratestart_button.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget({super.key, required this.store});
  final StoreModel store;
  @override
  Widget build(BuildContext context) {
    return bloc.BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Get.to(
                  StoreScreen(store: store),
                  transition: Transition.fade,
                  duration: const Duration(seconds: 1),
                );
              },
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
                                ? bloc.BlocProvider.of<HomeCubit>(context)
                                    .removeStoreFromFavorite(store.favorateId!)
                                : bloc.BlocProvider.of<HomeCubit>(context)
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
                          RatestartButton(store: store),
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

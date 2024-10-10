import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/models/gift_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        GiftModel? giftModel = BlocProvider.of<StoreCubit>(context)
            .giftList
            .where(
              (element) => element.id == id,
            )
            .firstOrNull;
        return InkWell(
          onTap: () => giftModel.favorate ?? false
              ? BlocProvider.of<StoreCubit>(context)
                  .removeGiftFromFavorite(giftModel.favorateId!)
              : BlocProvider.of<StoreCubit>(context).addGiftToFavorite(id),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.2,
            height: 50,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    color: ColorsManager.gray,
                    offset: Offset(2, 2),
                  )
                ],
                color: giftModel!.favorate ?? false
                    ? ColorsManager.white
                    : ColorsManager.red,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Center(
                child: FaIcon(
              FontAwesomeIcons.solidHeart,
              color: giftModel.favorate ?? false
                  ? ColorsManager.red
                  : ColorsManager.white,
            )),
          ),
        );
      },
    );
  }
}

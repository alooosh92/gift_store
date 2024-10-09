import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:rate/rate.dart';

class RateStartButton extends StatelessWidget {
  const RateStartButton({
    super.key,
    required this.id,
    required this.isStore,
    required this.start,
    required this.numRate,
  });
  final double start;
  final String id;
  final bool isStore;
  final double numRate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                  if (isStore) {
                    bloc.BlocProvider.of<HomeCubit>(context)
                        .rateStore(id, rate);
                  } else {
                    bloc.BlocProvider.of<StoreCubit>(context)
                        .rateGift(id, rate);
                  }
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
            " (${numRate.toInt()}) ",
            style: FontManager.s14w600cB,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: start.round() == 0 ? 1 : start.round(),
              itemBuilder: (context, index) => FaIcon(
                FontAwesomeIcons.solidStar,
                color: start.toInt() != 0
                    ? ColorsManager.primary
                    : ColorsManager.whiteDark1,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}

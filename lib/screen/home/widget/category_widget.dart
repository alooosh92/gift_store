import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.index,
    required this.text,
    required this.isRegion,
  });
  final int index;
  final String text;
  final bool isRegion;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: (isRegion
                            ? BlocProvider.of<HomeCubit>(context).region
                            : BlocProvider.of<HomeCubit>(context).category) ==
                        index
                    ? 4
                    : 2,
                color: ColorsManager.gray,
                offset: const Offset(2, 3),
              )
            ],
            color: isRegion
                ? index == BlocProvider.of<HomeCubit>(context).region
                    ? ColorsManager.primary
                    : ColorsManager.white
                : index == BlocProvider.of<HomeCubit>(context).category
                    ? ColorsManager.whiteDark1
                    : ColorsManager.whiteDark2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onTap: () => isRegion
                ? BlocProvider.of<HomeCubit>(context).changeRegion(index)
                : BlocProvider.of<HomeCubit>(context).changeCategore(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Center(
                child: Text(
                  text,
                  style: FontManager.s16w700cB,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

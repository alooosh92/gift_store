import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/screen/notices/notices_screen.dart';

class MassegeButton extends StatelessWidget {
  const MassegeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.to(const NoticesScreen(),
            transition: Transition.fade, duration: const Duration(seconds: 1)),
        icon: Row(
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: bloc.BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(
                      bloc.BlocProvider.of<HomeCubit>(context).numNotices != 0
                          ? bloc.BlocProvider.of<HomeCubit>(context)
                              .numNotices
                              .toString()
                          : "",
                      style: FontManager.s14w600cR,
                    );
                  },
                )),
            const FaIcon(
              FontAwesomeIcons.bell,
            ),
          ],
        ));
  }
}

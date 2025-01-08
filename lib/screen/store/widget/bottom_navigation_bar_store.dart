import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';

class BottomNavigationBarStore extends StatelessWidget {
  const BottomNavigationBarStore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        return BottomNavigationBar(
          iconSize: 30,
          selectedFontSize: 0,
          selectedItemColor: ColorsManager.primary,
          currentIndex: BlocProvider.of<StoreCubit>(context).page,
          onTap: (value) =>
              BlocProvider.of<StoreCubit>(context).changePage(value),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.house), label: ""),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.gifts), label: ""),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.comments), label: ""),
          ],
        );
      },
    );
  }
}

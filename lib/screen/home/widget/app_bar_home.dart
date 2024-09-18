import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/screen/home/widget/row_gategore.dart';
import 'package:gift_store/screen/notices/notices_screen.dart';

AppBar appBarHome(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
      bottomOpacity: 0.8,
      elevation: 2,
      shadowColor: ColorsManager.gray,
      title: const Text('الصفحة الرئيسية'),
      actions: [
        IconButton(
            onPressed: () => Get.to(const NoticesScreen(),
                transition: Transition.fade,
                duration: const Duration(seconds: 1)),
            icon: Row(
              children: [
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: bloc.BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Text(
                          bloc.BlocProvider.of<HomeCubit>(context).numNotices !=
                                  0
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
            ))
      ],
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        icon: const FaIcon(FontAwesomeIcons.bars),
      ),
      bottom: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 165),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SearchBar(
                  backgroundColor:
                      const WidgetStatePropertyAll(ColorsManager.white),
                  leading: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: ColorsManager.darkGray,
                    size: 14,
                  ),
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
                  hintText: "بحث",
                  onChanged: (val) {
                    bloc.BlocProvider.of<HomeCubit>(context)
                        .changeTextSearchBar(val);
                  },
                ),
              ),
              RowGategore(
                list: bloc.BlocProvider.of<HomeCubit>(context).regions,
                isRegion: true,
              ),
              RowGategore(
                list: bloc.BlocProvider.of<HomeCubit>(context).listCategore,
                isRegion: false,
              )
            ],
          )));
}

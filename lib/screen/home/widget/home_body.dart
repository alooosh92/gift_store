import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/screen/home/widget/store_widget.dart';

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

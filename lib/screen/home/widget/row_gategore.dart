import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/screen/home/widget/category_widget.dart';

class RowGategore extends StatelessWidget {
  const RowGategore({
    super.key,
    required this.list,
    required this.isRegion,
  });
  final List<String> list;
  final bool isRegion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) => CategoryWidget(
                      index: index,
                      text: list[index],
                      isRegion: isRegion,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}

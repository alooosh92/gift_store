import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_store/controller/home_cubit/home_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/models/notices_model.dart';
import 'package:gift_store/screen/widget/dialog_progress.dart';
import 'package:intl/intl.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاشعارات"),
      ),
      body: FutureBuilder<List<NoticesModel>>(
        future: BlocProvider.of<HomeCubit>(context).getNotices(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DialogProgress();
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("لا يوجد اشعارات لعرضها"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: snapshot.data![index].isRead
                        ? ColorsManager.white
                        : ColorsManager.whiteDark2,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(blurRadius: 1, offset: Offset(2, 2))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data![index].title,
                          style: FontManager.s16w700cB,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy - hh:mm')
                              .format(snapshot.data![index].createDate),
                          style: FontManager.s14w400cDg,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                    Text(
                      snapshot.data![index].message,
                      style: FontManager.s14w500cB,
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

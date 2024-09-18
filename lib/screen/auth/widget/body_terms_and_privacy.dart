import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/models/terms_model.dart';

class BodyTermsAndPrivacy extends StatelessWidget {
  const BodyTermsAndPrivacy({
    super.key,
    required this.future,
    required this.textAppBar,
  });
  final String textAppBar;
  final Future<List<TermsModel>> future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(textAppBar.tr)),
      body: FutureBuilder<List<TermsModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text("dontFindData".tr),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].title!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        snapshot.data![index].description!,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 5)
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/about_us/about_us.dart';
import 'package:gift_store/screen/home/widget/drawer_item.dart';

class DrawerWedget extends StatelessWidget {
  const DrawerWedget({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset("$imageLocalPath/logo.png"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerItem(text: "الملف الشخصي", press: () {}),
              DrawerItem(text: "طلباتي", press: () {}),
              DrawerItem(text: "سياسة الخصوصية", press: () {}),
              DrawerItem(text: "شروط الاستخدام", press: () {}),
              DrawerItem(
                  text: "من نحن",
                  press: () {
                    scaffoldKey.currentState!.closeDrawer();
                    Get.to(const AboutUsScreen());
                  }),
              DrawerItem(
                  text: "تسجيل خروج", press: () {}, withOutDivider: true),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حقوق النشر محفوظة لشركة AloshCo'),
              SizedBox(width: 5),
              FaIcon(FontAwesomeIcons.copyright, size: 12),
            ],
          )
        ],
      )),
    );
  }
}

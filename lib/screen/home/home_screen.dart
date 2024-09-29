import 'package:flutter/material.dart';
import 'package:gift_store/screen/home/widget/app_bar_home.dart';
import 'package:gift_store/screen/home/widget/drawer_wedget.dart';
import 'package:gift_store/screen/home/widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarHome(context, scaffoldKey),
      drawer: const DrawerWedget(),
      body: const HomeBody(),
    );
  }
}

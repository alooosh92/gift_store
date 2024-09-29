import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gift_store/data/colors.dart';

class BottomNavigationBarStore extends StatelessWidget {
  const BottomNavigationBarStore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      selectedFontSize: 0,
      selectedItemColor: ColorsManager.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: ""),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gifts), label: ""),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.comments), label: ""),
      ],
    );
  }
}

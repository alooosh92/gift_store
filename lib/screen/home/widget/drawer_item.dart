import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.press,
    required this.text,
    this.withOutDivider,
  });
  final String text;
  final Function() press;
  final bool? withOutDivider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Text(text),
          withOutDivider ?? false ? const SizedBox() : const Divider(),
        ],
      ),
    );
  }
}

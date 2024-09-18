import 'package:flutter/material.dart';

class ElevatedDefulte extends StatelessWidget {
  const ElevatedDefulte({
    super.key,
    required this.color,
    required this.widget,
    required this.press,
  });
  final Color color;
  final Widget widget;
  final Function()? press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          fixedSize: WidgetStatePropertyAll(
              Size(MediaQuery.sizeOf(context).width - 100, 48))),
      onPressed: press,
      child: widget,
    );
  }
}

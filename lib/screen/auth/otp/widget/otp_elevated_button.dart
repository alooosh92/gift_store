import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpElevatedButton extends StatelessWidget {
  const OtpElevatedButton({
    super.key,
    required this.color,
    required this.isLeft,
    required this.press,
    required this.text,
    required this.textStyle,
  });
  final Color color;
  final Function() press;
  final String text;
  final TextStyle textStyle;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          fixedSize: WidgetStatePropertyAll(
            Size(MediaQuery.sizeOf(context).width / 2 - 30, 50),
          ),
          shape: isLeft
              ? const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20))))
              : const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20))))),
      onPressed: press,
      child: Text(
        text.tr,
        style: textStyle,
      ),
    );
  }
}

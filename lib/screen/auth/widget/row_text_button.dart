import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/font.dart';

class RowTextButton extends StatelessWidget {
  const RowTextButton({
    super.key,
    required this.hintText,
    required this.press,
    required this.textButton,
  });
  final String hintText;
  final String textButton;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          hintText.tr,
          style: FontManager.s14w500cDb,
          overflow: TextOverflow.fade,
        ),
        InkWell(
          onTap: press,
          child: Text(
            textButton.tr,
            style: FontManager.s14w500cP,
            overflow: TextOverflow.fade,
          ),
        )
      ],
    );
  }
}

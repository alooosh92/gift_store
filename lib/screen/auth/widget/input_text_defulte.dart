import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';

class InputTextDefulte extends StatefulWidget {
  const InputTextDefulte({
    super.key,
    this.showPassword,
    required this.controller,
    required this.hint,
    required this.text,
    required this.texttype,
    this.validator,
  });
  final bool? showPassword;
  final TextInputType texttype;
  final String hint;
  final String text;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  State<InputTextDefulte> createState() => _InputTextDefulteState();
}

bool show = true;

class _InputTextDefulteState extends State<InputTextDefulte> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.text.tr,
                style: FontManager.s14w700cB,
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: widget.showPassword == null ? false : show,
            keyboardType: widget.texttype,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
                suffixIcon: widget.showPassword == null
                    ? null
                    : InkWell(
                        onTap: () => setState(() {
                          show = !show;
                        }),
                        child: Icon(show
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                      ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: ColorsManager.red)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: widget.hint.tr,
                hintStyle: FontManager.s16w700cB),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_store/data/colors.dart';

class TextFieldDef extends StatelessWidget {
  const TextFieldDef(
      {super.key,
      required this.name,
      required this.label,
      this.lines,
      this.enabled,
      this.validator,
      this.textInputType});

  final TextEditingController name;
  final String label;
  final int? lines;
  final bool? enabled;
  final bool? validator;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        keyboardType: textInputType,
        enabled: enabled,
        maxLines: lines,
        minLines: lines,
        controller: name,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            labelText: label,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorsManager.primary)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: validator ?? true
            ? (value) =>
                value == null || value.isEmpty ? "الرجاء ادخال قيمة" : null
            : null,
      ),
    );
  }
}

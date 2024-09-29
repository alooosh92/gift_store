import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/data/font.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommunicationButton extends StatelessWidget {
  const CommunicationButton({
    super.key,
    required this.icon,
    required this.text,
    required this.url,
  });
  final String url;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      onPressed: () async {
        if (await canLaunchUrlString(url)) {
          launchUrlString(url);
        }
      },
      label: Text(text, style: FontManager.s14w500cB),
      icon: FaIcon(icon, color: ColorsManager.black),
    );
  }
}

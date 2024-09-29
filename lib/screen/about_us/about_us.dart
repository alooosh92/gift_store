import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gift_store/data/font.dart';
import 'package:gift_store/data/values.dart';
import 'package:gift_store/screen/about_us/widget/communication_button.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("من نحن"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("$imageLocalPath/logo.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "نظرة عامة عن الشركة",
                    style: FontManager.s14w700cB,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "نحن شركة ناشئ تعمل داخل الجمهورية العربية السورية لبناء التطبيقات الاجهزة المحمولة والمواقع الالكترونية وتطبيقات سطح المكتب بأحدث اطر العمل المتواجدة بالسوق و تقديم الحلول البرمجية للشركات لمساعدتها على زيادة مبيعاتها تحت سقف قانون الجمهورية العربية السورية",
                    style: FontManager.s14w500cB,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "طرق التواصل",
                    style: FontManager.s14w700cB,
                    overflow: TextOverflow.fade,
                  ),
                  const CommunicationButton(
                    url: "tel:00963956108642",
                    text: "00963956108642",
                    icon: FontAwesomeIcons.phone,
                  ),
                  const CommunicationButton(
                    url: "whatsapp://send?phone=963956108642",
                    text: "00963956108642",
                    icon: FontAwesomeIcons.whatsapp,
                  ),
                  const CommunicationButton(
                    url: "https://t.me/AlaaNidalBaaj",
                    text: "@AlaaNidalBaaj",
                    icon: FontAwesomeIcons.telegram,
                  ),
                  const CommunicationButton(
                    url: "mailto:the.lost.admiral@gmail.com",
                    text: "the.lost.admiral@gmail.com",
                    icon: FontAwesomeIcons.envelope,
                  ),
                  const CommunicationButton(
                    url: "https://github.com/alooosh92",
                    text: "https://github.com/alooosh92",
                    icon: FontAwesomeIcons.github,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "معنا حقق احلامك",
                  style: FontManager.s14w700cB,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

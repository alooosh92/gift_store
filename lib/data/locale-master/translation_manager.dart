import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'languages/ar.dart';
import 'languages/en.dart';

class TranslationManager extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}

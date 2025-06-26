import 'package:auto_fin/core/data/local/app_get_storage.dart';
import 'package:get/get.dart';

mixin LanguageMixinController {
  RxString selectedLanguage = 'English'.obs;
  RxList<String> languages = ['English', 'Vietnamese'].obs;
  void setLanguage(String language) {
    selectedLanguage.value = language;
    AppGetStorage.setLanguage(language);
  }
}

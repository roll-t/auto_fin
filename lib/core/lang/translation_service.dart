import 'dart:collection';

import 'package:auto_fin/core/lang/vi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en.dart';

class LocalizationService extends Translations {
  // Fallback to user's saved language or default to 'en'
  static Locale? locale;

  // Default fallback locale if the chosen language isn't supported
  static const fallbackLocale = Locale('vi', 'VN');

  // Supported language codes
  static final langCodes = [
    'en',
    'vi',
  ];

  // Supported locales
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  // Language options for display (e.g., for dropdown)
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  // Method to change locale dynamically
  static void changeLocale(String langCode) {
    locale = _getLocaleFromLanguage(langCode: langCode);
    if (locale != null) {
      Get.updateLocale(locale!);
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  // Private function to get locale from language code
  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return fallbackLocale; // Return fallback if language code is not valid
  }
}

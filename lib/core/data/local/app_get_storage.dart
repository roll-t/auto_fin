import 'dart:convert';

import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/core/lang/translation_service.dart';
import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  // Tên các box có thể dùng nếu bạn muốn mở rộng
  static final GetStorage _box = GetStorage(); // default box

  // ========== Init ========== //
  static Future<void> init() async {
    await GetStorage.init(); // default init
    // Nếu có box phụ: await GetStorage.init('settings');
  }

  // ========== Keys ========== //
  static const String _themeKey = 'isDarkMode';
  static const String _tokenKey = 'accessToken';
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _selectedLanguageKey = 'selected_language';
  static const String _primaryThemeKey = 'primary_theme';
  static const String _isNotificationEnabled = 'isNotificationEnabled';

  // ========== Theme ========== //
  static void saveTheme(bool isDark) => _box.write(_themeKey, isDark);
  static bool getTheme() => _box.read(_themeKey) ?? false;

  // Save primary theme as string (using the enum name)
  static void savePrimaryTheme(AppColorTheme theme) =>
      _box.write(_primaryThemeKey, theme.toString());

  // Get primary theme (returning the enum)
  static AppColorTheme getPrimaryTheme(AppColorTheme fallback) {
    final themeString = _box.read<String>(_primaryThemeKey);
    if (themeString != null) {
      return AppColorTheme.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => fallback,
      );
    }
    return fallback;
  }

  // Lưu trạng thái bật/tắt thông báo
  static void setNotificationEnabled(bool value) =>
      _box.write(_isNotificationEnabled, value);

  static bool isNotificationEnabled() =>
      _box.read(_isNotificationEnabled) ?? true;

  // ========== Token ========== //
  static void saveToken(String token) => _box.write(_tokenKey, token);
  static String? getToken() => _box.read(_tokenKey);

  // ========== Login ========== //
  static void setLoggedIn(bool value) => _box.write(_isLoggedIn, value);
  static bool isLoggedIn() => _box.read(_isLoggedIn) ?? false;

  // ========== Language ========== //
  static void setLanguage(String language) {
    // Save selected language to GetStorage
    _box.write(_selectedLanguageKey, language);
    // Update the locale in the app
    LocalizationService.changeLocale(language == 'English' ? 'en' : 'vi');
  }

  static String getLanguage() {
    // Default to English if not set
    return _box.read(_selectedLanguageKey) ?? 'English';
  }

  // ========== Custom Data ========== //
  static void write<T>(String key, T value) => _box.write(key, value);
  static T? read<T>(String key) => _box.read<T>(key);
  static void remove(String key) => _box.remove(key);
  static void clear() => _box.erase();

  // ========== Control size ========== //

  // Ước tính kích thước của dữ liệu lưu trữ trong GetStorage (theo bytes)
  static int estimateCacheSize() {
    // Lấy tất cả các keys và dữ liệu trong bộ nhớ
    List<String> keys = _box.getKeys().toList();
    int totalSize = 0;

    for (String key in keys) {
      var value = _box.read(key);

      // Tính kích thước của từng giá trị theo loại dữ liệu
      if (value is String) {
        totalSize += utf8.encode(value).length;
      } else if (value is int) {
        totalSize += 4; // Kích thước của int là 4 bytes
      } else if (value is double) {
        totalSize += 8; // Kích thước của double là 8 bytes
      } else if (value is bool) {
        totalSize += 1; // Kích thước của bool là 1 byte
      } else {
        // Xử lý các kiểu dữ liệu phức tạp (List, Map, Object, v.v)
        totalSize += utf8.encode(value.toString()).length;
      }
    }

    return totalSize;
  }

  // Hàm in kích thước bộ nhớ cache (theo MB)
  static void printCacheSize() {
    int cacheSizeInBytes = estimateCacheSize();
    double cacheSizeInMB =
        cacheSizeInBytes / (1024 * 1024); // Chuyển từ bytes sang MB
    print("Kích thước bộ nhớ cache: ${cacheSizeInMB.toStringAsFixed(2)} MB");
  }
}

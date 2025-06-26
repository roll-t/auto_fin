import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Feature toggle controller đọc từ `.env`
///
/// Sử dụng trong code: `FeatureConfigs.isNotificationEnabled`
class FeatureConfigs {
  static final _env = dotenv.env;

  static bool get isNotificationEnabled =>
      _env['FEATURE_NOTIFICATION']?.toLowerCase() == 'true';

  static bool get isThemeSwitchEnabled =>
      _env['FEATURE_THEME_SWITCH']?.toLowerCase() == 'true';

  static bool get isRealtimeEnabled =>
      _env['FEATURE_REALTIME']?.toLowerCase() == 'true';

  static bool get isSwitchLanguageEnanled =>
      _env['FEATURE_LANGUEGE']?.toLowerCase() == 'true';

}

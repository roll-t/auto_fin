import 'package:auto_fin/core/config/const/notification_constants.dart';
import 'package:auto_fin/core/data/local/app_get_storage.dart';
import 'package:auto_fin/core/services/notification/background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    const androidSettings = AndroidInitializationSettings('@drawable/i_logo');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    _initialized = true;
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    // Nếu người dùng đã tắt thông báo thì không hiện
    if (!AppGetStorage.isNotificationEnabled()) return;
    await initialize();
    const androidDetails = AndroidNotificationDetails(
      NotificationConstants.defaultNotificationChannelId,
      NotificationConstants.defaultNotificationChannelName,
      channelDescription:
          NotificationConstants.defaultNotificationChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/i_logo',
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }
}

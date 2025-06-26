import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:auto_fin/core/config/const/notification_constants.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initialBackgroundService(FlutterBackgroundService service) async {
  // ⚠️ Check nếu đang chạy rồi thì bỏ qua
  final isRunning = await service.isRunning();
  if (isRunning) {
    log("✅ Background service is already running.");
    return;
  }

  // ⚠️ Kiểm tra xem người dùng đã bật thông báo chưa
  final bool isNotificationEnabled =
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled() ??
      false;

  if (!isNotificationEnabled) {
    log(
      "🔕 Notification permission is not granted. Background service not started.",
    );
    return; // ❌ Không khởi tạo dịch vụ nếu chưa có quyền
  }

  // ✅ Đã bật thông báo, tiếp tục khởi tạo
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    NotificationConstants.notificationChannelId,
    NotificationConstants.defaultNotificationChannelName,
    importance: Importance.min,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: NotificationConstants.notificationChannelId,
      foregroundServiceNotificationId: NotificationConstants.notificationId,
    ),
    iosConfiguration: IosConfiguration(),
  );
  log("✅ Background service configured.");

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized(); // cần cho isolate

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // ❌ KHÔNG DÙNG:
    // GetX, FlutterLocalNotificationsPlugin, SharedPreferences, Firebase, etc.
  }

  // ✅ Chỉ sử dụng code thuần hoặc isolate-safe
  Timer.periodic(const Duration(seconds: 15), (timer) {
    service.invoke("update", {
      "current_time": DateTime.now().toIso8601String(),
    });
  });
}

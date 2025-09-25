// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui';

// import 'package:auto_find/core/config/const/app_logger.dart';
// import 'package:auto_find/core/local_storage/app_get_storage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin _localNoti =
//     FlutterLocalNotificationsPlugin();
    
// const _defaultNotificationDetails = NotificationDetails(
//   android: AndroidNotificationDetails(
//     'default_channel_id',
//     'Default Channel',
//     channelDescription: 'Thông báo chung',
//     importance: Importance.max,
//     priority: Priority.high,
//   ),
// );

// Future<void> initializeLocalNotifications() async {
     
//   const androidSettings = AndroidInitializationSettings('@drawable/i_logo');
//   const settings = InitializationSettings(android: androidSettings);
//   await _localNoti.initialize(settings);

//   // 👇 Thêm đoạn này để tạo channel
//   const androidChannel = AndroidNotificationChannel(
//     'loop_channel_id',
//     'Bookara Foreground Service',
//     description: 'Thông báo khi chạy nền',
//     importance: Importance.high,
//   );
//   await _localNoti
//       .resolvePlatformSpecificImplementation< 
//         AndroidFlutterLocalNotificationsPlugin
//       >()
//       ?.createNotificationChannel(androidChannel);
// }

// Future<void> showNotification({
//   required String title,
//   required String body,
//   int? id,
// }) async {
//   await _localNoti.show(
//     id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
//     title,
//     body,
//     _defaultNotificationDetails,
//   );
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await initializeLocalNotifications();
//   AppLogger.i("📩 [Background] ${message.notification?.title}");
//   await showNotification(
//     title: message.notification?.title ?? 'Thông báo',
//     body: message.notification?.body ?? '',
//     id: message.hashCode,
//   );
// }

// @pragma('vm:entry-point')
// void onStartServiceBackground(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   await Firebase.initializeApp();
//   await initializeLocalNotifications();
//   AppLogger.i("✅ Background service started");
//   FirebaseDatabase.instance
//       .ref()
//       .child('notifications')
//       .limitToLast(1)
//       .onChildAdded
//       .listen((event) async {
//         final data = event.snapshot.value;
//         if (data is Map) {
//           final message = data['message']?.toString();
//           final title = data['title']?.toString() ?? "Thông báo mới";
//           if (message != null && message.isNotEmpty) {
//             log("📥 New message from Realtime DB");
//             await showNotification(title: title, body: message);
//           }
//         }
//       });
// }

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStartServiceBackground,
//       isForegroundMode: true,
//       autoStart: true,
//       notificationChannelId: 'loop_channel_id',
//       initialNotificationTitle: 'Bookara chạy nền',
//       initialNotificationContent: 'Đang lắng nghe thông báo...',
//     ),
//     iosConfiguration: IosConfiguration(
//       onForeground: onStartServiceBackground,
//       onBackground: (_) async => true,
//     ),
//   );
// }

// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   bool _isInitialized = false;
//   Timer? _autoNotifyTimer;

//   Future<void> initialize() async {
//     if (_isInitialized) return;
//     _isInitialized = true;

//     if (!AppGetStorage.isNotificationEnabled()) {
//       log('🔕 Notifications are disabled.');
//       return;
//     }

//     final settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     log('🔔 Permission status: ${settings.authorizationStatus}');

//     if (settings.authorizationStatus != AuthorizationStatus.authorized) {
//       return;
//     }

//     await _messaging.setAutoInitEnabled(true);
//     await initializeLocalNotifications();

//     final token = await _messaging.getToken();
//     AppLogger.i("🔑 FCM Token: $token");

//     FirebaseMessaging.onMessage.listen((message) {
//       log('📩 [Foreground] ${message.notification?.title}');
//       _handleIncomingMessage(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       log('📬 [OpenedApp] ${message.notification?.title}');
//     });

//     final initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       log('📥 [InitialMessage] ${initialMessage.notification?.title}');
//     }

//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }

//   void _handleIncomingMessage(RemoteMessage message) {
//     showNotification(
//       title: message.notification?.title ?? 'Thông báo',
//       body: message.notification?.body ?? '',
//       id: message.hashCode,
//     );
//   }

//   void startAutoNotificationLoop() {
//     log('⏳ Auto noti loop started.');
//     // Bỏ trống hoặc thực thi nếu cần
//   }

//   void stopAutoNotificationLoop() {
//     _autoNotifyTimer?.cancel();
//     log('🛑 Auto notification loop stopped.');
//   }

//   Future<void> toggleNotification(bool enabled) async {
//     AppGetStorage.setNotificationEnabled(enabled);
//     final service = FlutterBackgroundService();

//     if (enabled) {
//       await initializeService();
//       await service.startService();
//       await initialize();
//       startAutoNotificationLoop();
//     } else {
//       await _localNoti.cancelAll();
//       await _messaging.setAutoInitEnabled(false);
//       stopAutoNotificationLoop();
//       service.invoke("stopService");
//     }
//   }
// }

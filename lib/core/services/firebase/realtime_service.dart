// import 'dart:developer';

// import 'package:auto_find/core/utils/notification_utils.dart';
// import 'package:firebase_database/firebase_database.dart';

// void listenToRealtimeDatabase() {
//   log("⚡ Bắt đầu lắng nghe Realtime Database");
//   FirebaseDatabase.instance
//       .ref()
//       .child('notifications')
//       .limitToLast(1)
//       .onChildAdded
//       .listen((event) {
//     log("📥 Có dữ liệu mới từ Realtime Database");

//     final data = event.snapshot.value;
//     if (data is Map) {
//       final String? message = data['message']?.toString();
//       final String title = data['title']?.toString() ?? "Thông báo mới";
//       if (message != null && message.isNotEmpty) {
//         NotificationUtils.showNotification(title: title, body: message);
//       }
//     }
//   });
// }

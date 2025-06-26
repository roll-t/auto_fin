import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['API_KEY_WEB']!,
    appId: dotenv.env['APP_ID_WEB']!,
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
    projectId: dotenv.env['PROJECT_ID']!,
    authDomain: dotenv.env['AUTH_DOMAIN'],
    storageBucket: dotenv.env['STORAGE_BUCKET'],
    measurementId: dotenv.env['MEASUREMENT_ID'],
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['API_KEY_ANDROID']!,
    appId: dotenv.env['APP_ID_ANDROID']!,
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
    projectId: dotenv.env['PROJECT_ID']!,
    storageBucket: dotenv.env['STORAGE_BUCKET'],
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['API_KEY_IOS']!,
    appId: dotenv.env['APP_ID_IOS']!,
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
    projectId: dotenv.env['PROJECT_ID']!,
    storageBucket: dotenv.env['STORAGE_BUCKET'],
    iosBundleId: dotenv.env['IOS_BUNDLE_ID'],
    iosClientId: dotenv.env['IOS_CLIENT_ID'],
    androidClientId: dotenv.env['ANDROID_CLIENT_ID'],
  );

  static final FirebaseOptions macos = ios; // Reuse if same
  static final FirebaseOptions windows = web; // Reuse if same
}

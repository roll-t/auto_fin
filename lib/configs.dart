import 'package:auto_fin/app_binding.dart';
import 'package:auto_fin/core/config/app_logger.dart';
import 'package:auto_fin/core/config/load_env.dart';
import 'package:auto_fin/core/data/local/storage_configs.dart';
import 'package:auto_fin/core/lang/language_configs.dart';
import 'package:auto_fin/core/services/firebase/firebase_config.dart';
import 'package:auto_fin/core/services/notification/notification_config.dart';
import 'package:flutter/material.dart';

Future<void> configs() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  AppLogger.init();
  AppBinding().dependencies();
  await storageConfigs();
  await firebaseConfigs();
  await notificationConfigs();
  await languageConfigs();
}

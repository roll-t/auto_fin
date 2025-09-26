import 'package:auto_find/app_binding.dart';
import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/config/load_env.dart';
import 'package:auto_find/core/config/storage_configs.dart';
import 'package:auto_find/core/lang/language_configs.dart';
import 'package:flutter/material.dart';

Future<void> configs() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  AppLogger.init();
  AppBinding().dependencies(); 
  await storageConfigs();
  await languageConfigs();
}


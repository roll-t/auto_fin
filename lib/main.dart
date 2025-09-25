import 'package:auto_find/app.dart';
import 'package:auto_find/configs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configs();
  runApp(const App());
}

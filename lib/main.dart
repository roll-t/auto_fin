import 'package:auto_fin/app.dart';
import 'package:auto_fin/configs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configs();
  runApp(const App());
}

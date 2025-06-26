import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TabPage {
  final String title;
  final Widget Function() pageBuilder;
  final Bindings? binding;

  TabPage({required this.title, required this.pageBuilder, this.binding});
}

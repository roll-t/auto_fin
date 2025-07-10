import 'package:flutter/material.dart';

extension NullCheckExtension on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension StringNullExt on String? {
  String orNA() => this ?? "N/A";
}

extension StringEmptyExt on String? {
  String orEmpty() => this ?? "";
}

extension WidgetVisibilityExtension on Widget? {
  Widget visible([bool isVisible = true]) {
    if (this == null || !isVisible) {
      return const SizedBox.shrink();
    }
    return this!;
  }
}

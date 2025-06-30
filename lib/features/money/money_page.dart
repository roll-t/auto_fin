import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class MoneyPage extends StatelessWidget {
  static String routeName = "/MoneyPage";
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextWidget(text: "MoneyPage"),
    );
  }
}

import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatelessWidget {
  static String routeName = "/CreditPage";
  const CreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextWidget(text: "CreditPage"),
    );
  }
}

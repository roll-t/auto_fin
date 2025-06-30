import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  static String routeName = "/PeoplePage";
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: TextWidget(text: "PeoplePage"));
  }
}

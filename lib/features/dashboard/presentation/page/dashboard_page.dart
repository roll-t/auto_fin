import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static String routeName = "/DashboardPage";
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(text: "text"),
      ),
    );
  }
}

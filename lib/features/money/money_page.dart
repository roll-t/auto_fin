import 'package:auto_fin/core/ui/widgets/grid_menu_feature.dart';
import 'package:auto_fin/features/money/money_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyPage extends GetView<MoneyController> {
  static String routeName = "/MoneyPage";
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridMenuFeature(items: controller.listMoneyFeature);
  }
}

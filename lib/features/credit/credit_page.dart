import 'package:auto_fin/core/ui/widgets/grid_menu_feature.dart';
import 'package:auto_fin/features/credit/credit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditPage extends GetView<CreditController> {
  static String routeName = "/CreditPage";
  const CreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridMenuFeature(items: controller.listCreditFeature);
  }
}

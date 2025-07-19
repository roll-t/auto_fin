import 'package:auto_fin/core/ui/widgets/grid_menu_feature.dart';
import 'package:auto_fin/features/diamond/diamond_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiamondPage extends GetView<DiamondController> {
  static String routeName = "/DiamondPage";
  const DiamondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridMenuFeature(items: controller.listDiamondFeature);
  }
}

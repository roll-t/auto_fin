import 'package:auto_fin/core/ui/widgets/grid_menu_feature.dart';
import 'package:auto_fin/features/showroom/showroom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowroomPage extends GetView<ShowroomController> {
  static String routeName = "/ShowroomPage";
  const ShowroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridMenuFeature(
      items: controller.listShowroomFeature,
    );
  }
}

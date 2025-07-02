import 'package:auto_fin/core/ui/widgets/item_menu_feature_widget.dart';
import 'package:auto_fin/features/showroom/showroom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowroomPage extends GetView<ShowroomController> {
  static String routeName = "/ShowroomPage";
  const ShowroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: controller.listShowroomFeature.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final dataItem = controller.listShowroomFeature[index];
        return ItemMenuFeatureWidget(
          title: dataItem.title,
          iconUrl: dataItem.iconUrl,
          routeNameUrl: dataItem.routeNameUrl,
        );
      },
    );
  }
}

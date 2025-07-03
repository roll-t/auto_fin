import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitManagePage extends GetView<ProfitManageController> {
  static String routeName = "/ProfitManagePage";
  const ProfitManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      bodyBuilder: Container(),
    );
  }
}

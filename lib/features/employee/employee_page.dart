import 'package:auto_fin/core/ui/widgets/grid_menu_feature.dart';
import 'package:auto_fin/features/employee/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeePage extends GetView<EmployeeController> {
  static String routeName = "/EmployeePage";
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridMenuFeature(items: controller.listEmployeeFeature);
  }
}

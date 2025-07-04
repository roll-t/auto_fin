import 'package:auto_fin/features/showroom/car_manage/presentation/controller/all_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclePage extends GetView<AllCarController> {
  static String routeName = "/VehiclePage";
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('VehiclePage'),
      ),
    );
  }
}

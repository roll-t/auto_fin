import 'package:auto_fin/features/showroom/all_card/presentation/controller/all_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarInAutoPage extends GetView<AllCarController> {
  static String routeName = "/CarInAutoPage";
  const CarInAutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('CarInAutoPage'),
      ),
    );
  }
}

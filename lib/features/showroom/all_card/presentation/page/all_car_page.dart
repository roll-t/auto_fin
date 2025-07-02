import 'package:auto_fin/features/showroom/all_card/presentation/controller/all_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarPage extends GetView<AllCarController> {
  static String routeName = "/AllCarPage";
  const AllCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AllCarPagePage'),
      ),
    );
  }
}

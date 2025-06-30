import 'package:auto_fin/features/main/presentation/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    // ignore: deprecated_member_use
    with
        SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(MainPage.routeName);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

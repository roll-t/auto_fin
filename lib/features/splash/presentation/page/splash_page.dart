import 'dart:math' as math;

import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/features/splash/presentation/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.darkest,
      body: Center(
        child: FadeTransition(
          opacity: controller.opacityAnimation,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppThemeColors.primary,
                  AppThemeColors.darkest,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    text: "WELCOME DUNGLAM",
                    size: 24,
                    color: AppThemeColors.lightest,
                    fontWeight: FontWeight.bold,
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: Transform.translate(
                      offset: const Offset(0, -9),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [0.0, 0.9],
                              colors: [
                                AppThemeColors.lightest.withValues(alpha: .3),
                                Colors.transparent,
                              ],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: TextWidget(
                            text: "WELCOME DUNGLAM",
                            size: 24,
                            color: AppThemeColors.lightest,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

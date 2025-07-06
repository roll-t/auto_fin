import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/app_bar/custom_appbar.dart';
import 'package:flutter/material.dart';

class StandardLayoutWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? navigationBar;
  final Widget bodyBuilder;
  final EdgeInsets? padding;
  final String? titleAppBar;
  final bool isUnfocusInput;
  const StandardLayoutWidget({
    super.key,
    this.appBar,
    this.padding,
    this.navigationBar,
    this.titleAppBar,
    this.isUnfocusInput = false,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppThemeColors.darker,
              AppThemeColors.lightest,
              AppColors.white,
              AppColors.white,
              AppColors.white,
              AppColors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: titleAppBar != null
              ? CustomAppBar(
                  title: titleAppBar,
                )
              : appBar,
          body: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ).copyWith(
                  top: 40,
                ),
            child: bodyBuilder,
          ),
          bottomNavigationBar: navigationBar,
        ),
      ),
    );
  }
}

import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class StandardLayoutWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? navigationBar;
  final Widget bodyBuilder;
  final EdgeInsets? paddinng;
  const StandardLayoutWidget({
    super.key,
    this.appBar,
    this.paddinng,
    this.navigationBar,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColors.darker,
            AppThemeColors.lightest,
            AppThemeColors.lightest,
            AppThemeColors.lightest,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: Padding(
          padding: paddinng ??
              const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(
                top: 40,
              ),
          child: bodyBuilder,
        ),
        bottomNavigationBar: navigationBar,
      ),
    );
  }
}

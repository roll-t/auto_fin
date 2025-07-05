import 'package:flutter/material.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/utils/utils.dart';

class CircleIconButton extends StatelessWidget {
  final String svgUrl;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const CircleIconButton({
    super.key,
    required this.svgUrl,
    required this.onTap,
    this.size = 30,
    this.iconSize = 20,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ??
              AppThemeColors.lighter.withValues(alpha: 0.5),
        ),
        child: Center(
          child: Utils.iconSvg(
            svgUrl: svgUrl,
            size: iconSize,
            color: iconColor ?? AppThemeColors.primary,
          ),
        ),
      ),
    );
  }
}

import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Utils {
  static SvgPicture iconSvg({
    required String svgUrl,
    double size = 25,
    Color? color,
  }) {
    return SvgPicture.asset(
      svgUrl ?? AppIcons.icNotUrl,
      width: size,
      height: size,
      
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}

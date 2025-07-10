import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:flutter/widgets.dart';

class AppContainerStyles {
  static BoxDecoration cardStyle() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 4,
          spreadRadius: 2,
          color: AppColors.darkest1.withValues(alpha: .1),
        ),
      ],
    );
  }
}

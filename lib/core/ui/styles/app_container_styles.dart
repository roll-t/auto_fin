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
  static BoxDecoration cardStyle2() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 4,
          spreadRadius: 1,
          color: AppColors.primary1.withValues(alpha: .08),
        ),
        BoxShadow(
          offset: const Offset(0, 0),
          blurRadius: 2,
          spreadRadius: 0,
          color: AppColors.primary1.withValues(alpha: .1),
        ),
      ],
    );
  }
}

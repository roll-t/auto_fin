// ignore: file_names
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sort_controller.dart';

class SortToggleWidget extends StatelessWidget {
  final VoidCallback? onSort;
  final SortController controller;
  const SortToggleWidget({
    super.key,
    required this.controller,
    this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSort?.call();
        controller.toggleSort.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColors.white.withValues(alpha: .8),
          border: Border.all(
            width: .5,
            color: AppColors.text400,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => TextWidget(
                text: controller.label,
                color: AppThemeColors.text100,
                textStyle: AppTextStyle.semiBold14,
              ),
            ),
            const SizedBox(width: 10),
            Utils.iconSvg(
              svgUrl: AppVectors.icFilter,
              color: AppThemeColors.primary,
            )
          ],
        ),
      ),
    );
  }
}

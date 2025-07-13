// ignore: file_names
import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sort_controller.dart';

class SortToggleWidget extends StatelessWidget {
  final SortController controller;
  const SortToggleWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.toggleSort,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppThemeColors.primary.withValues(
            alpha: .1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => TextWidget(
                text: controller.label,
                fontWeight: FontWeight.w500,
                color: AppThemeColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Utils.iconSvg(
              svgUrl: AppIcons.icFilter,
              color: AppThemeColors.primary,
            )
          ],
        ),
      ),
    );
  }
}

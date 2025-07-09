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
      child: Column(
        children: [
          Row(
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
        ],
      ),
    );
  }
}

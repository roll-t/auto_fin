import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/ui/widgets/expand/expand_controller.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandSectionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final ExpandController controller;

  const ExpandSectionWidget({
    super.key,
    required this.title,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: controller.toggle,
          child: Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: AppThemeColors.primary,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Utils.iconSvg(
                  svgUrl: AppIcons.icList,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextWidget(
                    text: title,
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark1,
                  ),
                ),
                Obx(() => Utils.iconSvg(
                      svgUrl: controller.isExpanded.value
                          ? AppIcons.icArrowUp
                          : AppIcons.icArrowDown,
                      size: 24,
                    ))
              ],
            ),
          ),
        ),
        Obx(
          () => AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: child,
            crossFadeState: controller.isExpanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ),
      ],
    );
  }
}

import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String? title;
  final String? urlIc;
  final VoidCallback? onTap;
  final bool isActive;
  const MenuItem({
    super.key,
    this.title,
    this.onTap,
    this.urlIc,
    this.isActive = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                if (isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.check_circle,
                      size: 20,
                      color: AppThemeColors.primary,
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                      color: AppThemeColors.primary.withOpacity(.2),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Utils.iconSvg(
                    svgUrl: urlIc ?? "/",
                    color: AppThemeColors.primary,
                  ),
                ),
              ],
            ),
            TextWidget(
              text: title.orNA(),
              textAlign: TextAlign.center,
              size: 12,
              textStyle: AppTextStyle.regular14,
            )
          ],
        ),
      ),
    );
  }
}

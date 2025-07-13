import 'dart:ui';

import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textTitleColor;
  final String? icon;
  final String? title;
  final double height;
  final List<Widget>? menuItem;
  final bool hideBack;
  final PreferredSizeWidget? bottomAppBar;
  final VoidCallback onBack;
  final double blurSigma;

  const CustomAppBar({
    super.key,
    this.backgroundColor,
    this.textTitleColor,
    this.icon,
    this.title = '',
    this.menuItem,
    this.height = 44.0,
    this.bottomAppBar,
    this.hideBack = false,
    this.onBack = _defaultOnBack,
    this.blurSigma = 10.0,
  });

  static void _defaultOnBack() {
    Get.back();
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottomAppBar?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      iconTheme: IconThemeData(
        color: textTitleColor ?? Colors.black,
      ),
      elevation: 0.5,
      bottom: bottomAppBar,
      title: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 5,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: (backgroundColor ?? AppThemeColors.light)
                  .withValues(alpha: 0.15),
            ),
            child: Row(
              children: [
                hideBack
                    ? const SizedBox.shrink()
                    : icon != null
                        ? GestureDetector(
                            onTap: onBack,
                            child: SvgPicture.asset(
                              icon!,
                              height: 11.0,
                              width: 11.0,
                              fit: BoxFit.scaleDown,
                              colorFilter: textTitleColor != null
                                  ? ColorFilter.mode(
                                      textTitleColor!,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                          )
                        : IconButton(
                            icon: Utils.iconSvg(
                              svgUrl: AppIcons.icArrowBack,
                            ),
                            color: textTitleColor ?? AppColors.white,
                            onPressed: onBack,
                          ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextWidget(
                    text: title.orNA(),
                    color: textTitleColor ?? AppColors.white,
                    size: 16,
                    maxLines: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...menuItem ?? [],
                const SizedBox(width: 20)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }
}

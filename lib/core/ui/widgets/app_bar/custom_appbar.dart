import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textTitleColor;
  final String? icon;
  final String? title;
  final double? height;
  final List<Widget>? menuItem;
  final bool hideBack;
  final PreferredSizeWidget? bottomAppBar;
  final Function() onBack;

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
  });

  static void _defaultOnBack() {
    Get.back();
  } // Default empty function

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: menuItem,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: textTitleColor,
      ),
      elevation: 0.5,
      bottom: bottomAppBar,
      leading: hideBack
          ? const SizedBox.shrink()
          : icon == null
              ? const BackButton()
              : IconButton(
                  icon: SvgPicture.asset(
                    icon!,
                    height: 11.0,
                    width: 11.0,
                  ),
                  onPressed: onBack,
                ),
      title: TextWidget(text: title.orNA(),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }
}

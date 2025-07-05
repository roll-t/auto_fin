import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/circle_icon_button%20_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/features/setting/presentation/page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? textTitleColor;
  final String? icon;
  final String title;
  final double? height;
  final List<Widget>? menuItem;
  final bool hideBack;
  final PreferredSizeWidget? bottomAppBar;

  const MainAppbar({
    super.key,
    this.textTitleColor,
    this.icon,
    this.title = '',
    this.menuItem,
    this.height = 44.0,
    this.bottomAppBar,
    this.hideBack = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        titleSpacing: 0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.transparent,
        toolbarHeight: preferredSize.height,
        iconTheme: IconThemeData(color: textTitleColor),
        bottom: bottomAppBar,
        title: _buildTitle(),
        actions: [_buildActionMenu()],
      );
    });
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: AppThemeColors.light.withValues(alpha: .15),
      ),
      child: Row(
        children: [
          TextWidget(
            text: "AutoFin",
            size: 20,
            fontWeight: FontWeight.bold,
            color: AppThemeColors.lightest,
          ),
          const SizedBox(width: 10),
          TextWidget(
            text: title,
            size: 16,
            fontWeight: FontWeight.bold,
            color: AppThemeColors.lightest,
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      decoration: BoxDecoration(
        color: AppThemeColors.light.withValues(alpha: .15),
      ),
      child: Row(
        children: [
          CircleIconButton(
            svgUrl: AppIcons.icSetting,
            onTap: () {
              Get.toNamed(SettingPage.routeName);
            },
          ),
          const SizedBox(width: 16),
          CircleIconButton(
            svgUrl: AppIcons.icUser,
            onTap: () {
              // handle user tap
            },
          ),
        ],
      ),
    );
  }
}

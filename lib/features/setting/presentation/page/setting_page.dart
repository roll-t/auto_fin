import 'package:auto_fin/core/config/const/app_content.dart';
import 'package:auto_fin/core/config/const/app_dimens.dart';
import 'package:auto_fin/core/config/enum.dart';
import 'package:auto_fin/core/config/feature_configs.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/features/setting/presentation/controller/setting_controller.dart';
import 'package:auto_fin/features/setting/presentation/widget/select_language_widget.dart';
import 'package:auto_fin/features/setting/presentation/widget/select_primary_theme_widget.dart';
import 'package:auto_fin/features/setting/presentation/widget/toggle_theme_mode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingPage extends GetView<SettingController> {
  static const String routeName = "/settings";
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppContent.settings.tr,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontSize: AppDimens.fontSizeAppBar),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _buildSettingsList(),
      ),
    );
  }

  List<Widget> _buildSettingsList() {
    final List<Widget> widgets = [];

    if (FeatureConfigs.isThemeSwitchEnabled) {
      widgets.addAll([
        const SettingItemWidget(
          titleKey: AppContent.dark,
          trailing: ToggleThemeModeWidget(),
        ),
        const SizedBox(height: 12),
        SettingItemWidget(
          titleKey: AppContent.theme,
          trailing: SelectPrimaryThemeWidget(width: 30.w),
        ),
        const SizedBox(height: 12),
      ]);
    }

    if (FeatureConfigs.isSwitchLanguageEnanled) {
      widgets.addAll([
        SettingItemWidget(
          titleKey: AppContent.language,
          trailing: SelectLanguageWidget(controller: controller, width: 30.w),
        ),
        const SizedBox(height: 12),
      ]);
    }

    if (FeatureConfigs.isNotificationEnabled) {
      widgets.add(
        Obx(
          () => SettingItemWidget(
            titleKey: 'notification',
            trailing: Switch(
              value: controller.isNotificationEnabled.value,
              onChanged: controller.toggleNotification,
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}

class SettingItemWidget extends StatelessWidget {
  final String titleKey;
  final Widget trailing;
  final Color? backgroundColor;

  const SettingItemWidget({
    super.key,
    required this.titleKey,
    required this.trailing,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppThemeColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextWidget(
              text: titleKey.tr,
              transform: TextTransformType.capitalizeWords,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

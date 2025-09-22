// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/setting/presentation/page/setting_page.dart';
import 'package:auto_find/core/config/theme/theme_controller.dart';
import 'package:auto_find/main/user/features/profile/presentation/widgets/info_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSection extends CustomState {
  const ProfileSection({super.key});

  @override
  Widget buildBody(BuildContext context) => const _ThemeBuilder();
}

///---> [Theme-setting-status]
class _ThemeBuilder extends StatelessWidget {
  const _ThemeBuilder();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      id: "THEME_SITTING_ID",

      ///[Not set const to update the status]
      // ignore: prefer_const_constructors
      builder: (context) => _BodyBuilder(),
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppThemeColors.background300,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 80),

          ///[Not set const to update the status]
          // ignore: prefer_const_constructors
          InfoProfileWidget(),
          const SizedBox(height: 40),

          ///[Not set const to update the status]
          // ignore: prefer_const_constructors
          SettingPage(),
        ],
      ),
    );
  }
}

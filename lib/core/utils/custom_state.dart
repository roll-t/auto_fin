import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recase/recase.dart';

import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/widgets/app_bar/custom_appbar.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:auto_find/core/utils/utils.dart';

/// ✅ Base class cho các màn hình Stateless sử dụng GetX
abstract class CustomState extends StatelessWidget {
  const CustomState({super.key});

  // ===== Route & Transition =====
  String get routeName => '/${ReCase(runtimeType.toString()).paramCase}';
  Transition get transition => Transition.fadeIn;
  Bindings? get binding => null;

  // ===== Page Config =====
  String? get title => null;
  bool get showBack => true;
  bool get isShowBack => true;
  bool get dismissKeyboard => false;
  bool get backgroundImage => false;
  Color? get backgroundColor => AppThemeColors.background300;
  EdgeInsets? get bodyPadding =>
      const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 15);

  // ===== AppBar & Navigation =====
  Widget? get appBar => null;
  Widget? get leadingIconAppBar => null;
  List<Widget>? get actionAppBar => null;
  Widget? get drawer => null;
  Widget? get floatingActionButton => null;
  Widget? get bottomNavigationBar => null;

  // ===== Body =====
  Widget buildBody(BuildContext context);
  Widget buildTabletBody(BuildContext context) => buildBody(context);

  // ===== AppBar Builder =====
  PreferredSizeWidget buildDefaultAppBar(BuildContext context) {
    return CustomAppBar(
      leadingIcon: leadingIconAppBar
      ,
      showBackButton: showBack,
      title: title,
      actions: actionAppBar,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (appBar != null) {
      return AppBar(
        leading: leadingIconAppBar ?? Utils.iconSvg(svgUrl: AppVectors.icArrowBack),
        backgroundColor: Colors.transparent,
        title: appBar,
      );
    }
    if (title != null) return buildDefaultAppBar(context);
    return null;
  }

  // ===== Background Builder =====
  Widget _buildBackground() {
    if (!backgroundImage) return const SizedBox.shrink();
    return Positioned(
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppThemeColors.appBar,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
      ),
    );
  }

  // ===== Build =====
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final body =
        size.width > 800 ? buildTabletBody(context) : buildBody(context);

    return GestureDetector(
      onTap: dismissKeyboard ? KeyboardUtils.hiddenKeyboard : null,
      child: Container(
        color: AppThemeColors.background300,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(color: backgroundColor ?? Colors.transparent),
            ),
            _buildBackground(),
            Scaffold(
              drawer: drawer,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context),
              body: body,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ],
        ),
      ),
    );
  }
}

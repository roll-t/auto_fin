import 'package:auto_find/core/config/const/app_images.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/images/asset_image_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/user/features/auth/login/presentation/controller/login_controller.dart';
import 'package:auto_find/main/user/features/auth/signin/presentation/page/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends CustomState {
  const LoginPage({super.key});
  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<LoginController> {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetImageWidget(
            assetPath: AppImages.iLogo,
            width: 20.w,
          ),
          const SizedBox(height: 18),
          const TextWidget(
            text: "Đăng nhập",
            textStyle: AppTextStyle.bold30,
          ),
          const SizedBox(height: 40),
          CustomTextField(
            hintText: "Tên đăng nhập",
            controller: controller.userNameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: "Mật khẩu",
            controller: controller.passwordController,
            onSubmit: (_) => controller.onLogin(),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: "Đăng Nhập",
            textSize: 18,
            isMaxParent: true,
            onPressed: controller.onLogin,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(
                text: "Chưa có tài khoản. ",
              ),
              GestureDetector(
                onTap: () {
                  Get.offAndToNamed(const SigninPage().routeName);
                },
                child: TextWidget(
                  textStyle: AppTextStyle.medium12,
                  text: "Đăng ký ngay",
                  color: AppThemeColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

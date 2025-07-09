import 'package:auto_fin/core/config/const/app_images.dart';
import 'package:auto_fin/core/config/const/enum.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogUtils {
  static void showAlert({
    required AlertType alertType,
    String? title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Đồng ý',
    String cancelText = 'Hủy',
  }) {
    final config = _getAlertConfig(alertType);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: config.bgColor.withValues(alpha: .2),
                radius: 24,
                child: Icon(
                  config.icon,
                  color: config.color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              TextWidget(
                text: title ?? 'Thông báo',
                fontWeight: FontWeight.bold,
                color: AppColors.neutralColor2,
                size: 16,
              ),
              const SizedBox(height: 12),
              TextWidget(
                text: content ?? '',
                textAlign: TextAlign.center,
                size: 14,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onCancel?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(cancelText),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: config.color,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(confirmText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hiển thị dialog xác nhận thoát App
  static void showCustomExitConfirm() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: Image.asset(
                  AppImages.iLogo,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(height: 12),

              /// Tiêu đề
              const TextWidget(
                text: 'AutoFin',
                fontWeight: FontWeight.bold,
                size: 18,
                color: Colors.black,
              ),
              const SizedBox(height: 8),

              /// Nội dung
              const TextWidget(
                text: 'Bạn có muốn thoát ứng dụng không ?',
                textAlign: TextAlign.center,
                size: 14,
                color: Colors.black87,
              ),
              const SizedBox(height: 24),

              /// Nút bấm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// NO
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Ở lại',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// YES
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text(
                      'Thoát',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static _AlertConfig _getAlertConfig(AlertType type) {
    switch (type) {
      case AlertType.success:
        return _AlertConfig(
          color: AppColors.success,
          bgColor: AppColors.success,
          icon: Icons.check_circle_outline,
        );
      case AlertType.error:
        return _AlertConfig(
          color: AppColors.error,
          bgColor: AppColors.error,
          icon: Icons.error_outline,
        );
      case AlertType.warning:
        return _AlertConfig(
          color: AppColors.warning,
          bgColor: AppColors.warning,
          icon: Icons.warning_amber_outlined,
        );
    }
  }
}

/// Class chứa config cho từng loại alert
class _AlertConfig {
  final Color color;
  final Color bgColor;
  final IconData icon;

  _AlertConfig({
    required this.color,
    required this.bgColor,
    required this.icon,
  });
}

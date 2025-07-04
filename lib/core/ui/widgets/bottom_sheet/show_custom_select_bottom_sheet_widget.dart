import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> showCustomSelectBottomSheet<T>({
  required String title,
  required List<T> dataList,
  required String Function(T data) getLabel,
  T? initialValue,
}) async {
  T selectedItem = initialValue ?? dataList.first;

  FixedExtentScrollController scrollController = FixedExtentScrollController(
    initialItem: initialValue != null ? dataList.indexOf(initialValue) : 0,
  );

  return await Get.bottomSheet<T>(
    Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkest1.withValues(alpha: .1),
            offset: const Offset(0, -1),
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.neutralColor2,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppThemeColors.dark,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListWheelScrollView.useDelegate(
              controller: scrollController,
              itemExtent: 40,
              physics: const FixedExtentScrollPhysics(),
              perspective: 0.002,
              onSelectedItemChanged: (index) {
                selectedItem = dataList[index];
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (_, index) {
                  if (index >= dataList.length) return null;
                  final item = dataList[index];
                  return Center(
                    child: Text(
                      getLabel(item),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppThemeColors.dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neutralColor2,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Hủy",
                    style: TextStyle(
                      color: AppColors.dark1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemeColors.primary,
                  ),
                  onPressed: () {
                    Get.back(result: selectedItem);
                  },
                  child: const Text(
                    "Chọn",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

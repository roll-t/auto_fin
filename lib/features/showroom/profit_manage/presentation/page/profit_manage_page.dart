import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/ui/styles/app_container_styles.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/core/ui/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/widgets/tabs_section/car_profit_section.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/widgets/tabs_section/year_profit_car_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitManagePage extends GetView<ProfitManageController> {
  static String routeName = "/ProfitManagePage";
  const ProfitManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.only(top: 25),
      titleAppBar: "Quản lý lợi nhuận",
      bodyBuilder: Column(
        children: [
          ProfitAvenueWidget(controller: controller),
          const SizedBox(height: 20),
          CustomTabBarWidget(
            label: "Tiêu chí thống kê",
            controller: controller.tabBarController,
            tabBodies: const [
              YearProfitCarSection(),
              CarProfitSection(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfitAvenueWidget extends StatelessWidget {
  const ProfitAvenueWidget({
    super.key,
    required this.controller,
  });

  final ProfitManageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: AppContainerStyles.cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomBottomSheetWidget(
                  hint: "Chọn năm",
                  controller: controller.yearBottomSheetController,
                  onSelectedItem: (ItemModel item) {
                    controller.yearSelected = item;
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomBottomSheetWidget(
                  hint: "Chọn tháng",
                  controller: controller.monthBottomSheetController,
                  onSelectedItem: (ItemModel item) {
                    controller.yearSelected = item;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TextSpanWidget(
                  fontWeight2: FontWeight.bold,
                  textColor2: AppThemeColors.secondary,
                  text1: "Tổng giá trị: ",
                  text2: "161,333,500,000 VNĐ",
                ),
                const SizedBox(height: 16),
                TextSpanWidget(
                  fontWeight2: FontWeight.bold,
                  textColor2: AppThemeColors.secondary,
                  text1: "Tổng lợi nhuận: ",
                  text2: "8,823,900,000 VNĐ",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/ui/styles/app_container_styles.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/core/ui/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitManagePage extends GetView<ProfitManageController> {
  static String routeName = "/ProfitManagePage";
  const ProfitManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      titleAppBar: "Quản lý lợi nhuận",
      bodyBuilder: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppContainerStyles.cardStyle(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: TextWidget(
                    text: "Thông Tin",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
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
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      TextSpanWidget(
                        fontWeight1: FontWeight.bold,
                        text1: "Tổng giá trị: ",
                        text2: "161,333,500,000 VNĐ",
                      ),
                      SizedBox(height: 16),
                      TextSpanWidget(
                        fontWeight1: FontWeight.bold,
                        text1: "Tổng lợi nhuận: ",
                        text2: "8,823,900,000 VNĐ",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: AppContainerStyles.cardStyle(),
            child: CustomTabBarWidget(
              tabs: const ["Tab 1", "Tab 2", "Tab 3"],
              selectedIndex: 0,
              onTap: (int value) {},
            ),
          )
        ],
      ),
    );
  }
}

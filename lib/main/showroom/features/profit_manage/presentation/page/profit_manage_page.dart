import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/shimmer/shimmer_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/widgets/tabs_section/car_profit_section.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/widgets/tabs_section/year_profit_car_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitManagePage extends CustomState {
  const ProfitManagePage({super.key});

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  String? get title => "Quản lý lợi nhuận";

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const _ProfitAvenueWidget(),
        const SizedBox(height: 20),

        // Tab bar + Tab bar view
        Expanded(
          child: GetBuilder<ProfitManageController>(
            id: "TAB_BAR_ID",
            builder: (controller) {
              return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    WrapBodyWidget(
                      margin: AppPadding.h16,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: .5,
                                color: AppColors.accent.withValues(alpha: .5),
                              ),
                            ),
                            child: TabBar(
                              dividerHeight: 0,
                              labelColor: Colors.white,
                              unselectedLabelColor: AppColors.grey,
                              indicator: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: const [
                                Tab(text: "Thống kê theo năm"),
                                Tab(text: "Thống kê theo xe"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CustomPopupDropdown(
                                controller: controller.filterCarPopup,
                                onSelected: controller.onFilterSelected,
                              ),
                              const SizedBox(width: 50),
                              const Expanded(child: SearchWidget(height: 40))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: TabBarView(
                        children: [
                          controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : YearProfitCarSection(controller: controller),
                          controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const CarProfitSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProfitAvenueWidget extends GetView<ProfitManageController> {
  const _ProfitAvenueWidget();

  @override
  Widget build(BuildContext context) {
    return WrapBodyWidget(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      header: Row(
        children: [
          const Expanded(
            child: TextWidget(
              text: "Thống kê doanh thu",
              textStyle: AppTextStyle.semiBold14,
            ),
          ),
          SizedBox(
            width: 120,
            child: CustomBottomSheetWidget(
              leadingIconUrl: AppVectors.icCurrency,
              height: 30,
              hint: "Chọn đơn vị tiền",
              titleBottomSheet: "Chọn đơn vị tiền tệ",
              controller: controller.currencyUnitController,
              onSelectedItem: controller.onCurrencyUnitChanged,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomBottomSheetWidget(
                  label: "Năm",
                  hint: "Chọn năm",
                  titleBottomSheet: "Chọn năm",
                  controller: controller.yearBottomSheetController,
                  onSelectedItem: controller.onYearSelected,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomBottomSheetWidget(
                  label: "Tháng",
                  hint: "Chọn tháng",
                  titleBottomSheet: "Chọn tháng",
                  controller: controller.monthBottomSheetController,
                  onSelectedItem: controller.onMonthSelected,
                ),
              ),
            ],
          ),
          GetBuilder<ProfitManageController>(
            id: "TOTAL_PROFIT_ID",
            builder: (_) {
              final String totalValue = controller.totalValue
                  .toCurrencyWithUnit(controller.currencyUnitController);
              final String totalProfit = controller.totalProfit
                  .toCurrencyWithUnit(controller.currencyUnitController);
              if (controller.isLoading) {
                return const Column(
                  children: [
                    SizedBox(height: 16),
                    ShimmerWidget(
                      height: 16,
                      width: 220,
                    ),
                    SizedBox(height: 16),
                    ShimmerWidget(
                      height: 16,
                      width: 220,
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  TextSpanWidget(
                    maxLine: 1,
                    fontWeight2: FontWeight.bold,
                    textColor2: AppColors.accent,
                    text1: "Tổng giá trị bán: ",
                    text2: totalValue,
                  ),
                  const SizedBox(height: 16),
                  TextSpanWidget(
                    maxLine: 1,
                    fontWeight2: FontWeight.bold,
                    textColor2: AppColors.accent,
                    text1: "Tổng lợi nhuận: ",
                    text2: totalProfit,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/controller/statistic_vehicle_controller.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class StatisticVehiclePage extends CustomState {
  const StatisticVehiclePage({super.key});

  @override
  String? get title => "Thống kê Showroom";

  @override
  bool get backgroundImage => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticVehicleController>(
      id: "CHART_ID",
      builder: (controller) {
        final chartsData = controller.charts;
        if (chartsData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final months = List.generate(12, (i) => "T${i + 1}");
        final soldNow = List.generate(
            12, (i) => chartsData.lineSoldCount?.seriesYear?[i] ?? 0);
        final soldPrev = List.generate(
            12, (i) => chartsData.lineSoldCount?.seriesPrev?[i] ?? 0);

        return SingleChildScrollView(
          padding: AppPadding.h16,
          child: Column(
            children: [
              const SizedBox(height: 12),
              WrapBodyWidget(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: CustomBottomSheetWidget(
                        hint: "Chọn năm",
                        titleBottomSheet: "Chọn năm",
                        controller: controller.yearBottomSheetController,
                        onSelectedItem: controller.onYearSelected,
                      ),
                    ),
                    const _ButtonShowOrderStatistic()
                  ],
                ),
                child: Column(
                  children: [
                    TextWidget(
                      text:
                          "Số lượng xe bán ra năm ${chartsData.lineSoldCount?.year ?? ''}",
                    ),
                    SizedBox(
                      height: 300,
                      child: charts.SfCartesianChart(
                        plotAreaBorderColor: AppColors.grey,
                        legend: const charts.Legend(isVisible: true),
                        primaryXAxis: const charts.CategoryAxis(
                          interval: 1,
                          labelPlacement: charts.LabelPlacement.onTicks,
                          labelStyle: TextStyle(
                            color: AppColors.text500,
                            fontSize: 8,
                          ),
                          majorGridLines: charts.MajorGridLines(
                            color: AppColors.grey,
                            width: 0.5,
                          ),
                          axisLine: charts.AxisLine(
                            color: Colors.transparent,
                          ),
                        ),
                        primaryYAxis: const charts.NumericAxis(
                          labelStyle: TextStyle(
                            color: AppColors.text500,
                            fontSize: 10,
                          ),
                          majorGridLines: charts.MajorGridLines(
                            color: AppColors.grey,
                            width: 0.5,
                            dashArray: <double>[5, 5],
                          ),
                          axisLine: charts.AxisLine(
                            color: Colors.transparent,
                          ),
                        ),
                        series: <charts.CartesianSeries>[
                          charts.LineSeries<int, String>(
                            name: "Năm nay",
                            dataSource: soldNow,
                            xValueMapper: (value, index) => months[index],
                            yValueMapper: (value, _) => value,
                          ),
                          charts.LineSeries<int, String>(
                            name: "Năm rồi",
                            dataSource: soldPrev,
                            xValueMapper: (value, index) => months[index],
                            yValueMapper: (value, _) => value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ButtonShowOrderStatistic extends StatelessWidget {
  const _ButtonShowOrderStatistic();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Center(
            child: Container(
              width: Get.width * .95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: AppThemeColors.primary,
                    ),
                    child: Row(
                      children: [
                        Utils.iconSvg(
                          svgUrl: AppVectors.icChart,
                          size: 20,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                          child: TextWidget(
                            text: "Thống kê khác",
                            textAlign: TextAlign.start,
                            textStyle: AppTextStyle.regular16,
                            color: AppColors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MenuItem(
                          title: "Số lượng xe bán ra /Năm",
                          urlIc: AppVectors.icFinance,
                          onTap: () {
                            Get.back();
                          },
                          isActive: true,
                        ),
                        MenuItem(
                          urlIc: AppVectors.icCar,
                          title: "Showroom",
                          onTap: () {
                            Get.back();
                          },
                        ),
                        MenuItem(
                          urlIc: AppVectors.icCash,
                          title: "Dòng tiền",
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: true,
        );
      },
      child: Container(
        height: 35,
        padding: AppPadding.h16,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppThemeColors.primary.withValues(alpha: .5),
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppThemeColors.primary.withValues(alpha: .2),
        ),
        child: Row(
          children: [
            Utils.iconSvg(
              svgUrl: AppVectors.icChart,
              color: AppThemeColors.primary,
            ),
            const SizedBox(width: 4),
            TextWidget(
              text: "Thống kê khác",
              color: AppThemeColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardActionWidget extends StatelessWidget {
  const DashboardActionWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(
          Center(
            child: Container(
              width: Get.width * .95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: AppColors.primary1_500,
                    ),
                    child: Row(
                      children: [
                        Utils.iconSvg(
                          svgUrl: AppVectors.icChart,
                          size: 20,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                          child: TextWidget(
                            text: "Báo cáo khác",
                            textAlign: TextAlign.start,
                            textStyle: AppTextStyle.regular16,
                            color: AppColors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MenuItem(
                          title: "Tài chính",
                          urlIc: AppVectors.icFinance,
                          onTap: () {
                            Get.back();
                          },
                          isActive: true,
                        ),
                        MenuItem(
                          urlIc: AppVectors.icCar,
                          title: "Showroom",
                          onTap: () {
                            Get.back();
                          },
                        ),
                        MenuItem(
                          urlIc: AppVectors.icCash,
                          title: "Dòng tiền",
                          onTap: () {
                            Get.back();
                          },
                        ),
                        MenuItem(
                          urlIc: AppVectors.icPerson,
                          title: "Nhân sự",
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary2_200,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
            color: AppColors.white,
          ),
        ),
        child: Row(
          children: [
            Utils.iconSvg(
              svgUrl: AppVectors.icChart,
              color: AppColors.primary1_500,
            ),
            const SizedBox(width: 5),
            const TextWidget(
              text: "Báo cáo khác",
              textStyle: AppTextStyle.regular12,
              color: AppColors.primary1_500,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/top_model.dart';
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
              _buildChartSection(
                  controller, months, soldNow, soldPrev, chartsData),
              const SizedBox(height: 20),
              _buildTopStatisticSection(controller),
              const SizedBox(height: 12),
              GetBuilder<StatisticVehicleController>(
                id: "TOP_ID",
                builder: (c) => _buildTopContent(c),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChartSection(
    StatisticVehicleController controller,
    List<String> months,
    List<int> soldNow,
    List<int> soldPrev,
    dynamic chartsData,
  ) {
    return WrapBodyWidget(
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
          const _ButtonShowOrderStatistic(),
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
                labelStyle: TextStyle(color: AppColors.text500, fontSize: 8),
                majorGridLines:
                    charts.MajorGridLines(color: AppColors.grey, width: 0.5),
                axisLine: charts.AxisLine(color: Colors.transparent),
              ),
              primaryYAxis: const charts.NumericAxis(
                labelStyle: TextStyle(color: AppColors.text500, fontSize: 10),
                majorGridLines: charts.MajorGridLines(
                  color: AppColors.grey,
                  width: 0.5,
                  dashArray: <double>[5, 5],
                ),
                axisLine: charts.AxisLine(color: Colors.transparent),
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
    );
  }

  Widget _buildTopStatisticSection(StatisticVehicleController controller) {
    return WrapBodyWidget(
      child: CustomBottomSheetWidget(
        label: "TOP thống kê",
        hint: "Top thống kê",
        titleBottomSheet: "Top thống kê",
        controller: controller.topStatisticBottomSheetController,
        onSelectedItem: controller.onTopStatisticSelected,
      ),
    );
  }

  Widget _buildTopContent(StatisticVehicleController c) {
    final selected = c.topStatisticSelected?.id;
    if (selected == null) return const TextWidget(text: "Chưa có dữ liệu");

    switch (selected) {
      /// Render cars section
      case "recent":
        return _CarListWidget(
          title: "Xe bán gần đây",
          cars: c.topRecent,
          controller: c,
        );
      case "profit":
        return _CarListWidget(
          title: "Xe có lợi nhuận cao nhất",
          cars: c.topProfit,
          controller: c,
        );
      case "value":
        return _CarListWidget(
          title: "Xe có giá trị cao nhất",
          cars: c.topValue,
          controller: c,
        );

      /// Render top order section
      case "brand":
        return _TopModelListWidget(
          title: "Hãng xe bán chạy nhất",
          items: c.topBrands,
        );
      case "product":
        return _TopModelListWidget(
          title: "Mẫu xe bán chạy nhất",
          items: c.topProducts,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

///---------------- Widgets nhỏ ----------------///

class _CarListWidget extends StatelessWidget {
  final String title;
  final List<CarModel> cars;
  final StatisticVehicleController controller;
  const _CarListWidget({
    required this.title,
    required this.cars,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) return const TextWidget(text: "Chưa có dữ liệu");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // WrapBodyWidget(
        //   child: TextWidget(text: title, textStyle: AppTextStyle.semiBold16),
        // ),
        ...cars.take(5).map((e) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextWidget(
                  text: e.name ?? "",
                  textStyle: AppTextStyle.medium14,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.topStatisticSelected?.id == "recent" ||
                      controller.topStatisticSelected?.id == "profit") ...[
                    TextSpanWidget(
                      textColor1: AppColors.grey,
                      textColor2:
                          (e.profit ?? 0) > 0 ? AppColors.green : AppColors.red,
                      fontWeight2: FontWeight.w500,
                      text1: "Tổng lợi nhuận: ",
                      text2: e.profit.toString().toCurrency(withSymbol: true),
                    ),
                    const SizedBox(height: 6.0),
                  ],
                  if (controller.topStatisticSelected?.id == "recent" ||
                      controller.topStatisticSelected?.id == "value")
                    TextSpanWidget(
                      textColor1: AppColors.grey,
                      textColor2: AppColors.blue,
                      fontWeight2: FontWeight.w500,
                      text1: "Giá bán: ",
                      text2:
                          e.soldPrice.toString().toCurrency(withSymbol: true),
                    ),
                  if (controller.topStatisticSelected?.id == "recent" ||
                      controller.topStatisticSelected?.id == "profit") ...[
                    const SizedBox(height: 6.0),
                    TextSpanWidget(
                      textColor1: AppColors.grey,
                      textColor2: AppColors.black,
                      fontWeight2: FontWeight.w500,
                      text1: "Ngày bán: ",
                      text2: e.soldDate.toString().toVNDate(),
                    ),
                  ],
                  if (controller.topStatisticSelected?.id == "value") ...[
                    const SizedBox(height: 6.0),
                    TextSpanWidget(
                      textColor1: AppColors.grey,
                      textColor2: AppColors.black,
                      fontWeight2: FontWeight.w500,
                      text1: "Ngày nhập: ",
                      text2: e.importDate.toString().toVNDate(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _TopModelListWidget extends StatelessWidget {
  final String title;
  final List<TopModel> items;
  const _TopModelListWidget({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const TextWidget(text: "Chưa có dữ liệu");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map((model) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: TextWidget(
                  text: "${model.product ?? model.brand}",
                  textStyle: AppTextStyle.semiBold14,
                ),
              ),
              subtitle: TextSpanWidget(
                textColor1: AppColors.grey,
                textColor2: AppColors.green,
                fontWeight2: FontWeight.w500,
                text1: "Tổng lợi nhuận",
                text2:
                    model.totalProfit.toString().toCurrency(withSymbol: true),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _ButtonShowOrderStatistic extends StatelessWidget {
  const _ButtonShowOrderStatistic();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showStatisticDialog,
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
                svgUrl: AppVectors.icChart, color: AppThemeColors.primary),
            const SizedBox(width: 4),
            TextWidget(text: "Thống kê khác", color: AppThemeColors.primary),
          ],
        ),
      ),
    );
  }

  void _showStatisticDialog() {
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
                decoration: BoxDecoration(
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
                        color: AppColors.white),
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
                      onTap: Get.back,
                      child: const Icon(Icons.close, color: AppColors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MenuItem(
                        title: "Số lượng xe\nbán ra",
                        urlIc: AppVectors.icCar,
                        onTap: Get.back,
                        isActive: true),
                    MenuItem(
                        title: "Doanh thu\nnăm 2025",
                        urlIc: AppVectors.icFinance,
                        onTap: Get.back),
                    MenuItem(
                        title: "Giá Trị Xe Nhập\nNăm 2025",
                        urlIc: AppVectors.icCash,
                        onTap: Get.back),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}

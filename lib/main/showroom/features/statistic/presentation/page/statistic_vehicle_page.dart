import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/currency_extensions.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/chart_data_model.dart';
import 'package:auto_find/main/showroom/data/model/top_model.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/controller/statistic_vehicle_controller.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
              Stack(
                children: [
                  _buildChartBySelection(
                    controller,
                    months,
                    soldNow,
                    soldPrev,
                    chartsData,
                  ),
                  if (controller.isLoadingChart == true)
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white.withOpacity(.5),
                      ),
                      child: Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: AppThemeColors.primary,
                          size: 40,
                        ),
                      ),
                    ))
                ],
              ),
              const SizedBox(height: 20),
              _buildTopStatisticSection(controller),
              const SizedBox(height: 12),
              GetBuilder<StatisticVehicleController>(
                id: "TOP_ID",
                builder: (c) {
                  if (c.isLoadingTopCategory == true) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return _buildTopContent(c);
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChartHeader(StatisticVehicleController controller) {
    return Row(
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
        _ButtonShowOrderStatistic(controller: controller),
      ],
    );
  }

  /// chọn chart theo `selectedChart`
  Widget _buildChartBySelection(
    StatisticVehicleController controller,
    List<String> months,
    List<int> soldNow,
    List<int> soldPrev,
    dynamic chartsData,
  ) {
    switch (controller.selectedChart) {
      case "profit":
        return _buildProfitChart(controller, months, chartsData);
      case "import":
        return _buildImportValueChart(controller, months, chartsData);
      case "sold":
      default:
        return _buildChartSection(
          controller,
          months,
          soldNow,
          soldPrev,
          chartsData,
        );
    }
  }

  Widget _buildChartSection(
    StatisticVehicleController controller,
    List<String> months,
    List<int> soldNow,
    List<int> soldPrev,
    dynamic chartsData,
  ) {
    // 👉 tính tổng
    final totalSoldNow = soldNow.fold<int>(0, (sum, v) => sum + v);
    final totalSoldPrev = soldPrev.fold<int>(0, (sum, v) => sum + v);

// 👉 số xe bán trong tháng hiện tại (chỉ khi năm được chọn là năm hiện tại)
    int? soldThisMonth;
    if (Utils.isCurrentYear(controller.yearSelected?.id)) {
      final currentMonthIndex = DateTime.now().month - 1;
      if (currentMonthIndex >= 0 && currentMonthIndex < soldNow.length) {
        soldThisMonth = soldNow[currentMonthIndex];
      }
    }

    return WrapBodyWidget(
      header: _buildChartHeader(controller),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text:
                "Tổng số lượng xe bán ra năm ${chartsData.lineSoldCount?.year ?? ''}",
            textStyle: AppTextStyle.semiBold14,
          ),
          const SizedBox(height: 10),
          // 👉 dòng tổng năm nay
          TextSpanWidget(
            text1: Utils.isCurrentYear(controller.yearSelected?.id)
                ? "Năm nay: "
                : "Năm nay (${controller.yearSelected?.id}): ",
            text2: "$totalSoldNow",
            textColor1: AppColors.text400,
            textColor2: AppColors.blue,
          ),
          const SizedBox(height: 6),
          TextSpanWidget(
            text1: "Năm trước: ",
            text2: "$totalSoldPrev",
            textColor1: AppColors.text400,
            textColor2: AppColors.blue,
          ),
          if (soldThisMonth.isNotNull) ...[
            const SizedBox(height: 6),
            TextSpanWidget(
              text1: "Số xe bán được tháng này: ",
              text2: "$soldThisMonth",
              textColor1: AppColors.text400,
              textColor2: AppColors.blue,
            ),
          ],
          const SizedBox(height: 8),
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
                  name: "Năm trước",
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

  Widget _buildImportValueChart(
    StatisticVehicleController controller,
    List<String> months,
    dynamic chartsData,
  ) {
    final importNow = List.generate(
      12,
      (i) => ChartDataModel(
        months[i],
        (chartsData.barImportValueMillion?.seriesYear?[i] ?? 0).toInt(),
      ),
    );

    final importPrev = List.generate(
      12,
      (i) => ChartDataModel(
        months[i],
        (chartsData.barImportValueMillion?.seriesPrev?[i] ?? 0).toInt(),
      ),
    );

    // 👉 Tính tổng giá trị nhập (triệu VND)
    final totalImportNow =
        importNow.fold<int>(0, (sum, item) => sum + item.value);
    final totalImportPrev =
        importPrev.fold<int>(0, (sum, item) => sum + item.value);

    // 👉 Tính % thay đổi
    String percentText;
    IconData iconData;
    Color iconColor;

    if (totalImportPrev == 0) {
      if (totalImportNow > 0) {
        percentText = "∞%";
        iconData = Icons.arrow_upward;
        iconColor = Colors.green;
      } else {
        percentText = "0%";
        iconData = Icons.remove;
        iconColor = Colors.grey;
      }
    } else {
      final percentChange =
          ((totalImportNow - totalImportPrev) / totalImportPrev) * 100;
      final isIncrease = percentChange >= 0;

      percentText = "${percentChange.toStringAsFixed(1)}%";
      iconData = isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
      iconColor = isIncrease ? Colors.green : Colors.red;
    }

    // 👉 Tính giá trị nhập trong tháng hiện tại (nếu là năm nay)
    int? importThisMonth;
    if (Utils.isCurrentYear(controller.yearSelected?.id)) {
      final currentMonthIndex = DateTime.now().month - 1;
      importThisMonth =
          (currentMonthIndex >= 0 && currentMonthIndex < importNow.length)
              ? importNow[currentMonthIndex].value
              : 0;
    }

    return WrapBodyWidget(
      header: _buildChartHeader(controller),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text:
                "Tổng giá trị xe nhập ${chartsData.lineSoldCount?.year ?? ''} (triệu VND)",
            textStyle: AppTextStyle.medium14,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextSpanWidget(
                maxLine: 1,
                text1:
                    "Năm nay ${Utils.isCurrentYear(controller.yearSelected?.id.toString()) ? "" : "(${controller.yearSelected?.id})"}: ",
                text2: "${totalImportNow.toString().toCurrency()} triệu",
                textColor1: AppColors.text400,
                textColor2: AppColors.blue,
              ),
              Row(
                children: [
                  const SizedBox(width: 12),
                  const TextWidget(text: "[", color: AppColors.grey),
                  Icon(iconData, color: iconColor, size: 14),
                  const SizedBox(width: 2),
                  TextWidget(
                    text: percentText,
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                    size: 12,
                  ),
                  const TextWidget(text: "]", color: AppColors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextSpanWidget(
            text1: "Năm trước: ",
            text2: "${totalImportPrev.toString().toCurrency()} triệu",
            textColor1: AppColors.text400,
            textColor2: AppColors.blue,
          ),
          if (Utils.isCurrentYear(controller.yearSelected?.id)) ...[
            const SizedBox(height: 6),
            TextSpanWidget(
              text1: "Giá trị nhập tháng này: ",
              text2: "$importThisMonth triệu",
              textColor1: AppColors.text400,
              textColor2: AppColors.blue,
            ),
          ],
          const SizedBox(height: 12),
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
                charts.ColumnSeries<ChartDataModel, String>(
                  name: "Năm nay",
                  dataSource: importNow,
                  xValueMapper: (data, _) => data.month,
                  yValueMapper: (data, _) => data.value,
                ),
                charts.ColumnSeries<ChartDataModel, String>(
                  name: "Năm trước",
                  dataSource: importPrev,
                  xValueMapper: (data, _) => data.month,
                  yValueMapper: (data, _) => data.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfitChart(
    StatisticVehicleController controller,
    List<String> months,
    dynamic chartsData,
  ) {
    final profitNow = List.generate(
      12,
      (i) => ChartDataModel(
        months[i],
        (chartsData.barProfitMillion?.seriesYear?[i] ?? 0).toInt(),
      ),
    );

    final profitPrev = List.generate(
      12,
      (i) => ChartDataModel(
        months[i],
        (chartsData.barProfitMillion?.seriesPrev?[i] ?? 0).toInt(),
      ),
    );

    // 👉 Tính tổng lợi nhuận
    final totalProfitNow =
        profitNow.fold<int>(0, (sum, item) => sum + item.value);
    final totalProfitPrev =
        profitPrev.fold<int>(0, (sum, item) => sum + item.value);

    // 👉 Tính % thay đổi
    String percentText;
    IconData iconData;
    Color iconColor;

    if (totalProfitPrev == 0) {
      if (totalProfitNow > 0) {
        percentText = "∞%";
        iconData = Icons.arrow_upward;
        iconColor = Colors.green;
      } else {
        percentText = "0%";
        iconData = Icons.remove;
        iconColor = Colors.grey;
      }
    } else {
      final percentChange =
          ((totalProfitNow - totalProfitPrev) / totalProfitPrev) * 100;
      final isIncrease = percentChange >= 0;
      percentText = "${percentChange.toStringAsFixed(1)}%";
      iconData = isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
      iconColor = isIncrease ? Colors.green : Colors.red;
    }

    // 👉 Tính lợi nhuận tháng hiện tại (nếu là năm nay)
    int? profitThisMonth;
    if (Utils.isCurrentYear(controller.yearSelected?.id)) {
      final currentMonthIndex = DateTime.now().month - 1;
      profitThisMonth =
          (currentMonthIndex >= 0 && currentMonthIndex < profitNow.length)
              ? profitNow[currentMonthIndex].value
              : 0;
    }

    return WrapBodyWidget(
      header: _buildChartHeader(controller),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text:
                "Tổng doanh thu ${chartsData.lineSoldCount?.year ?? ''} (triệu VND)",
            textStyle: AppTextStyle.medium14,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextSpanWidget(
                maxLine: 1,
                text1:
                    "Năm nay ${Utils.isCurrentYear(controller.yearSelected?.id.toString()) ? "" : "(${controller.yearSelected?.id})"}: ",
                text2: "${totalProfitNow.toString().toCurrency()} triệu",
                textColor1: AppColors.text400,
                textColor2: AppColors.green,
              ),
              Row(
                children: [
                  const SizedBox(width: 12),
                  const TextWidget(text: "[", color: AppColors.grey),
                  Icon(iconData, color: iconColor, size: 14),
                  const SizedBox(width: 2),
                  TextWidget(
                    text: percentText,
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                    size: 12,
                  ),
                  const TextWidget(text: "]", color: AppColors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextSpanWidget(
            text1: "Năm trước: ",
            text2: "${totalProfitPrev.toString().toCurrency()} triệu",
            textColor1: AppColors.text400,
            textColor2: AppColors.green,
          ),
          if (Utils.isCurrentYear(controller.yearSelected?.id)) ...[
            const SizedBox(height: 6),
            TextSpanWidget(
              text1: "Lợi nhuận tháng này: ",
              text2: "$profitThisMonth triệu",
              textColor1: AppColors.text400,
              textColor2: AppColors.green,
            ),
          ],
          const SizedBox(height: 12),
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
                charts.ColumnSeries<ChartDataModel, String>(
                  name: "Năm nay",
                  dataSource: profitNow,
                  xValueMapper: (data, _) => data.month,
                  yValueMapper: (data, _) => data.value,
                ),
                charts.ColumnSeries<ChartDataModel, String>(
                  name: "Năm trước",
                  dataSource: profitPrev,
                  xValueMapper: (data, _) => data.month,
                  yValueMapper: (data, _) => data.value,
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
      case "recent":
        return _CarListWidget(
            title: "Xe bán gần đây", cars: c.topRecent, controller: c);
      case "profit":
        return _CarListWidget(
            title: "Xe có lợi nhuận cao nhất",
            cars: c.topProfit,
            controller: c);
      case "value":
        return _CarListWidget(
            title: "Xe có giá trị cao nhất", cars: c.topValue, controller: c);
      case "brand":
        return _TopModelListWidget(
            title: "Hãng xe bán chạy nhất", items: c.topBrands);
      case "product":
        return _TopModelListWidget(
            title: "Mẫu xe bán chạy nhất", items: c.topProducts);
      default:
        return const SizedBox.shrink();
    }
  }
}

/// ---------------- Widgets nhỏ ---------------- ///

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
  final StatisticVehicleController controller;
  const _ButtonShowOrderStatistic({required this.controller});

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
            color: AppThemeColors.primary.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppThemeColors.primary.withOpacity(.2),
        ),
        child: Row(
          children: [
            Utils.iconSvg(
              svgUrl: AppVectors.icChart,
              color: AppThemeColors.primary,
            ),
            const SizedBox(width: 4),
            TextWidget(text: "Thống kê khác", color: AppThemeColors.primary),
          ],
        ),
      ),
    );
  }

  void _showStatisticDialog() {
    final controller = Get.find<StatisticVehicleController>();
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
                      onTap: () {
                        controller.selectChart("sold");
                        Get.back();
                      },
                      isActive: controller.selectedChart == "sold",
                    ),
                    MenuItem(
                      title: "Doanh thu\nnăm 2025",
                      urlIc: AppVectors.icFinance,
                      onTap: () {
                        controller.selectChart("profit");
                        Get.back();
                      },
                      isActive: controller.selectedChart == "profit",
                    ),
                    MenuItem(
                      title: "Giá trị xe nhập\nnăm 2025",
                      urlIc: AppVectors.icCash,
                      onTap: () {
                        controller.selectChart("import");
                        Get.back();
                      },
                      isActive: controller.selectedChart == "import",
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
  }
}

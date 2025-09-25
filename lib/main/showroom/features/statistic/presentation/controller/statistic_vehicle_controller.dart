import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_chart_model.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/top_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticVehicleController extends GetxController {
  StatisticVehicleController(this._carUsecase);
  final CarUsecase _carUsecase;

  CarChartsModel? charts;
  final headerTabSelectedIndex = 0.obs;
  bool isLoadingTopCategory = false;
  bool isLoadingChart = false;

  String selectedChart = "sold"; // mặc định: số lượng xe bán ra

  List<TopModel> topBrands = [];
  List<TopModel> topProducts = [];
  List<CarModel> topProfit = [];
  List<CarModel> topValue = [];
  List<CarModel> topRecent = [];

  ItemModel? yearSelected;
  ItemModel? topStatisticSelected;

  final colorController = TextEditingController();

  final BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: _yearItems().obs,
    itemSelected: _yearItems()[0],
  );

  final BottomSheetController topStatisticBottomSheetController =
      BottomSheetController(
    listItem: [
      ItemModel(title: "Xe Bán Gần Đây", id: "recent"),
      ItemModel(title: "Xe Có Lợi Nhuận Cao Nhất", id: "profit"),
      ItemModel(title: "Xe Có Giá Trị Cao Nhất", id: "value"),
      ItemModel(title: "Hãng Xe Bán Chạy Nhất", id: "brand"),
      ItemModel(title: "Mẫu Xe Bán Chạy Nhất", id: "product"),
    ].obs,
    itemSelected: ItemModel(title: "Xe Bán Gần Đây", id: "recent"),
  );

  @override
  void onReady() {
    super.onReady();
    initialData();
  }

  void initialData() {
    final firstYear = int.parse(_yearItems()[0].id.orEmpty());
    yearSelected = _yearItems()[0];
    topStatisticSelected = topStatisticBottomSheetController.itemSelected.value;
    fetchChart(year: firstYear);
    fetchTopStatistic(ItemModel(id: "recent"));
  }

  Future<void> fetchChart({required int year}) async {
    isLoadingChart = true;
    update(["CHART_ID"]);
    final results = await _carUsecase.getCharts(year);
    if (results != null) {
      charts = results as CarChartsModel;
      isLoadingChart = false;
      update(["CHART_ID"]);
    }
  }

  Future<void> fetchTopStatistic(ItemModel selected) async {
    isLoadingTopCategory = true;
    update(["TOP_ID"]);
    topBrands = [];
    topProducts = [];
    topProfit = [];
    topValue = [];
    topRecent = [];
    switch (selected.id) {
      case 'recent':
        topRecent = await _carUsecase.getTopRecent();
        break;
      case 'profit':
        topProfit = await _carUsecase.getTopProfit();
        break;
      case 'value':
        topValue = await _carUsecase.getTopValue();
        break;
      case 'brand':
        topBrands = await _carUsecase.getTopBrands();
        break;
      case 'product':
        topProducts = await _carUsecase.getTopProducts();
        break;
    }
    topStatisticSelected = selected;
    isLoadingTopCategory = false;
    update(['TOP_ID']);
  }

  void selectChart(String chartId) {
    selectedChart = chartId;
    update(["CHART_ID"]);
  }

  void onYearSelected(ItemModel item) {
    yearSelected = item;
    final year = int.tryParse(item.id.orEmpty());
    if (year != null) fetchChart(year: year);
  }

  Future<void> onTopStatisticSelected(ItemModel item) async {
    topStatisticSelected = item;
    topStatisticBottomSheetController.itemSelected.value = item;
    await fetchTopStatistic(item);
  }

  Future<void> onSetSelectedHeaderTab(int index) async {
    if (headerTabSelectedIndex.value == index) return;
    headerTabSelectedIndex.value = index;
    update(['HEADER_MANAGE_CAR_ID']);
  }

  static List<ItemModel> _yearItems() {
    final currentYear = DateTime.now().year;
    return [
      for (int y = currentYear; y >= 2018; y--)
        ItemModel(id: "$y", title: "Năm $y"),
    ];
  }
}

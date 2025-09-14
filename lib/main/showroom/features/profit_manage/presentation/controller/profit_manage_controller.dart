import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/tab_bar/custom_tab_bar_controller.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class ProfitManageController extends GetxController {
  final CarUsecase _carUsecase;
  ProfitManageController(this._carUsecase);

  ProfitMatrixResponseModel profitMatrix = ProfitMatrixResponseModel();
  ItemModel? yearSelected;
  ItemModel? monthSelected;

  String? totalValue;
  String? totalProfit;
  bool isLoading = true;

  BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: [
      ItemModel(id: "", title: "Tất cả"),
      ItemModel(id: "2025", title: "Năm 2025"),
      ItemModel(id: "2024", title: "Năm 2024"),
      ItemModel(id: "2023", title: "Năm 2023"),
      ItemModel(id: "2022", title: "Năm 2022"),
      ItemModel(id: "2021", title: "Năm 2021"),
      ItemModel(id: "2020", title: "Năm 2020"),
      ItemModel(id: "2019", title: "Năm 2019"),
      ItemModel(id: "2018", title: "Năm 2018"),
    ].obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  BottomSheetController currencyUnitController = BottomSheetController(
    listItem: [
      ItemModel(id: "vnd", title: "VND"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "vnd", title: "VND"),
  );

  final BottomSheetController monthBottomSheetController =
      BottomSheetController(
    listItem: List.generate(13, (index) {
      if (index == 0) {
        return ItemModel(id: "", title: "Tất cả");
      }
      return ItemModel(id: "$index", title: "Tháng $index");
    }).obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  final TabBarController tabBarController = TabBarController(
    tabs: [
      ItemModel(id: UniqueKey().toString(), title: "Theo năm"),
      ItemModel(id: UniqueKey().toString(), title: "Theo xe"),
    ],
  );

  @override
  void onReady() {
    super.onReady();
    fetchProfitMatrix();
  }

  Future<void> fetchProfitMatrix() async {
    try {
      isLoading = true;
      final year =
          yearSelected != null ? int.tryParse(yearSelected?.id ?? "0") : null;
      final month =
          monthSelected != null ? int.tryParse(monthSelected?.id ?? "0") : null;
      profitMatrix =
          await _carUsecase.getProfitMatrix(year: year, month: month);
      final totals = profitMatrix.totals;
      totalValue = totals?.grandSoldValue?.toStringAsFixed(0) ?? "0";
      totalProfit = totals?.grandProfit?.toStringAsFixed(0) ?? "0";
    } catch (e) {
      AppLogger.e("❌ Lỗi khi gọi getProfitMatrix: $e");
    } finally {
      isLoading = false;
      update([
        "TOTAL_PROFIT_ID",
        "TAB_BAR_ID",
      ]);
    }
  }

  void onYearSelected(ItemModel item) {
    yearSelected = item;
    if (monthSelected?.id != null) {
      monthSelected = ItemModel(id: "", title: "Tất cả");
      monthBottomSheetController.itemSelected.value =
          ItemModel(id: "", title: "Tất cả");
    }
    fetchProfitMatrix();
  }

  void onMonthSelected(ItemModel item) {
    monthSelected = item;
    fetchProfitMatrix();
  }

  void onCurrencyUnitChanged(ItemModel item) {
    currencyUnitController.itemSelected.value = item;
    update(["TOTAL_PROFIT_ID"]);
  }

  @override
  void onClose() {
    yearBottomSheetController.dispose();
    monthBottomSheetController.dispose();
    super.onClose();
  }
}

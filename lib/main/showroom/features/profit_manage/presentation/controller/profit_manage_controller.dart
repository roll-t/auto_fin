import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/tab_bar/custom_tab_bar_controller.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfitManageController extends GetxController {
  final CarUsecase _carUsecase;
  ProfitManageController(this._carUsecase);

  /// State
  final profitMatrix = ProfitMatrixResponseModel().obs;
  final RxList<MonthProfit> listMonthProfit = <MonthProfit>[].obs;
  String totalValue = "0";
  String totalProfit = "0";
  bool isLoading = true;

  ItemModel? yearSelected;
  ItemModel? monthSelected;

  /// Dropdown filter
  final PopupDropdownController filterCarPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả'),
      PopupDropdownModel(id: 'highest', label: 'Cao nhất'),
      PopupDropdownModel(id: 'lowest', label: 'Thấp nhất'),
    ].obs,
  );

  /// Năm
  final BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: _yearItems().obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  /// Đơn vị tiền
  final BottomSheetController currencyUnitController = BottomSheetController(
    listItem: [
      ItemModel(id: "vnd", title: "VND"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "vnd", title: "VND"),
  );

  /// Tháng
  final BottomSheetController monthBottomSheetController =
      BottomSheetController(
    listItem: _monthItems().obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  /// Tab bar
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

      final year = int.tryParse(yearSelected?.id ?? "");
      final month = int.tryParse(monthSelected?.id ?? "");

      final result =
          await _carUsecase.getProfitMatrix(year: year, month: month);
      profitMatrix.value = result;
      listMonthProfit.value = profitMatrix.value.toListMonthProfit();

      final totals = result.totals;
      totalValue = totals?.grandSoldValue?.toStringAsFixed(0) ?? "0";
      totalProfit = totals?.grandProfit?.toStringAsFixed(0) ?? "0";
    } catch (e) {
      AppLogger.e("❌ Lỗi khi gọi getProfitMatrix: $e");
    } finally {
      isLoading = false;
      update(["TOTAL_PROFIT_ID", "TAB_BAR_ID"]);
    }
  }

  void onYearSelected(ItemModel item) {
    yearSelected = item;

    // Reset tháng khi chọn năm
    monthSelected = ItemModel(id: "", title: "Tất cả");
    monthBottomSheetController.itemSelected.value = monthSelected!;

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

  List<MonthProfit> sortByProfitDesc(List<MonthProfit> list) {
    final sorted = [...list];
    sorted.sort((a, b) => b.profit.compareTo(a.profit));
    return sorted;
  }

  List<MonthProfit> sortByProfitAsc(List<MonthProfit> list) {
    final sorted = [...list];
    sorted.sort((a, b) => a.profit.compareTo(b.profit));
    return sorted;
  }

  void onFilterSelected(PopupDropdownModel item) {
    filterCarPopup.selectedItem.value = item;

    final monthProfits = profitMatrix.value.toListMonthProfit();

    switch (item.id) {
      case "highest":
        listMonthProfit.value = sortByProfitDesc(monthProfits);
        break;
      case "lowest":
        listMonthProfit.value = sortByProfitAsc(monthProfits);
        break;
      default:
        listMonthProfit.value = monthProfits;
    }

    update(["TAB_BAR_ID"]);
  }

  /// Helper: tạo list năm động
  static List<ItemModel> _yearItems() {
    final currentYear = DateTime.now().year;
    return [
      ItemModel(id: "", title: "Tất cả"),
      for (int y = currentYear; y >= 2018; y--)
        ItemModel(id: "$y", title: "Năm $y"),
    ];
  }

  /// Helper: tạo list tháng
  static List<ItemModel> _monthItems() {
    return [
      ItemModel(id: "", title: "Tất cả"),
      for (int m = 1; m <= 12; m++) ItemModel(id: "$m", title: "Tháng $m"),
    ];
  }

  @override
  void onClose() {
    // Giải phóng BottomSheetController
    yearBottomSheetController.dispose();
    monthBottomSheetController.dispose();
    currencyUnitController.dispose();

    // Giải phóng PopupDropdownController
    filterCarPopup.dispose();

    // Xoá reference các biến để GC dọn dẹp
    yearSelected = null;
    monthSelected = null;

    super.onClose();
  }
}

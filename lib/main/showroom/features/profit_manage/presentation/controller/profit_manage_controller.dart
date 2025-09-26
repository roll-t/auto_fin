// (giữ nguyên các import của bạn)
import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/tab_bar/custom_tab_bar_controller.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitManageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CarUsecase _carUsecase;
  ProfitManageController(this._carUsecase);

  // ===============================
  // State
  // ===============================
  final profitMatrix = ProfitMatrixResponseModel().obs;
  final RxList<MonthProfit> listMonthProfit = <MonthProfit>[].obs;
  final RxList<MonthProfit> originListMonthProfit = <MonthProfit>[].obs;

  // Lưu bản gốc của soldList để reset / search chính xác
  final RxList<CarModel> originSoldList = <CarModel>[].obs;

  String totalValue = "0";
  String totalProfit = "0";
  bool isLoading = true;

  ItemModel? yearSelected;
  ItemModel? monthSelected;

  late TabController tabController;
  final RxInt currentTabIndex = 0.obs;

  // ===============================
  // Controllers
  // ===============================
  final TextEditingController searchController = TextEditingController();

  final PopupDropdownController filterProfitPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả'),
      PopupDropdownModel(id: 'highest', label: 'Cao nhất'),
      PopupDropdownModel(id: 'lowest', label: 'Thấp nhất'),
      PopupDropdownModel(id: 'newest', label: 'Gần nhất'),
      PopupDropdownModel(id: 'oldest', label: 'Xa nhất'),
    ].obs,
  );

  final PopupDropdownController filterCarPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả'),
      PopupDropdownModel(id: 'profit_highest', label: 'Cao nhất (lợi nhuận)'),
      PopupDropdownModel(id: 'profit_lowest', label: 'Thấp nhất (lợi nhuận)'),
      PopupDropdownModel(id: 'soldValue_highest', label: 'Cao nhất (giá bán)'),
      PopupDropdownModel(id: 'soldValue_lowest', label: 'Thấp nhất (giá bán)')
    ].obs,
  );

  final BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: _yearItems().obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  final BottomSheetController monthBottomSheetController =
      BottomSheetController(
    listItem: _monthItems().obs,
    itemSelected: ItemModel(id: "", title: "Tất cả"),
  );

  final BottomSheetController currencyUnitController = BottomSheetController(
    listItem: [
      ItemModel(id: "vnd", title: "VND"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "vnd", title: "VND"),
  );

  final TabBarController tabBarController = TabBarController(
    tabs: [
      ItemModel(id: UniqueKey().toString(), title: "Theo năm"),
      ItemModel(id: UniqueKey().toString(), title: "Theo xe"),
    ],
  );

  // ===============================
  // Lifecycle
  // ===============================
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_onTabChanged);
  }

  @override
  void onReady() {
    super.onReady();
    fetchProfitMatrix();
  }

  @override
  void onClose() {
    yearBottomSheetController.dispose();
    monthBottomSheetController.dispose();
    currencyUnitController.dispose();
    filterProfitPopup.dispose();
    filterCarPopup.dispose();
    tabController.dispose();
    searchController.dispose();
    yearSelected = null;
    monthSelected = null;
    super.onClose();
  }

  // ===============================
  // API
  // ===============================
  Future<void> fetchProfitMatrix() async {
    try {
      isLoading = true;

      final year = int.tryParse(yearSelected?.id ?? "");
      final month = int.tryParse(monthSelected?.id ?? "");

      final result =
          await _carUsecase.getProfitMatrix(year: year, month: month);
      profitMatrix.value = result!;

      // Month profit lists
      final data = profitMatrix.value.toListMonthProfit();
      originListMonthProfit.value = data;
      listMonthProfit.value = data;

      // Sold car list: lưu bản gốc để search/reset
      originSoldList.value = result.soldList ?? [];
      // Keep profitMatrix.soldList as the currently displayed list:
      profitMatrix.update((val) {
        if (val != null) val.soldList = [...originSoldList];
      });

      final totals = result.totals;
      totalValue = totals?.grandSoldValue?.toStringAsFixed(0) ?? "0";
      totalProfit = totals?.grandProfit?.toStringAsFixed(0) ?? "0";
    } catch (e) {
      AppLogger.e("❌ Lỗi khi gọi getProfitMatrix: $e");
    } finally {
      isLoading = false;
      update(["TOTAL_PROFIT_ID", "TAB_BAR_ID", "SOLD_LIST_ID"]);
    }
  }

  // ===============================
  // Event Handlers
  // ===============================
  void _onTabChanged() {
    // hide keyboard, reset search text when tab changes
    // (tabController.indexIsChanging not used here)
    KeyboardUtils.hiddenKeyboard();
    currentTabIndex.value = tabController.index;
    searchController.text = "";
    // when switching to "Theo xe" we might want to show original list
    if (currentTabIndex.value == 1) {
      // restore full soldList from origin
      profitMatrix.update((val) {
        if (val != null) val.soldList = [...originSoldList];
      });
      update(["SOLD_LIST_ID"]);
    } else {
      // restore month profits origin as well
      listMonthProfit.value = originListMonthProfit;
      update(["TAB_BAR_ID"]);
    }
    update(["TAB_BAR_ID"]);
  }

  void onTabChangedExternally(int index) {
    tabController.animateTo(index);
    _onTabChanged();
  }

  void onYearSelected(ItemModel item) {
    yearSelected = item;
    monthSelected = ItemModel(id: "", title: "Tất cả");
    filterProfitPopup.selectedItem.value = const PopupDropdownModel(id: 'all', label: 'Tất cả');
    filterCarPopup.selectedItem.value = const PopupDropdownModel(id: 'all', label: 'Tất cả');
    monthBottomSheetController.itemSelected.value = monthSelected!;
    fetchProfitMatrix();
  }

  void onMonthSelected(ItemModel item) {
    monthSelected = item;
    filterProfitPopup.selectedItem.value = const PopupDropdownModel(id: 'all', label: 'Tất cả');
    filterCarPopup.selectedItem.value = const PopupDropdownModel(id: 'all', label: 'Tất cả');
    fetchProfitMatrix();
  }

  void onCurrencyUnitChanged(ItemModel item) {
    currencyUnitController.itemSelected.value = item;
    update(["TOTAL_PROFIT_ID"]);
  }

  /// entry point for filter button (decide tab)
  void onFilter(PopupDropdownModel item) {
    final idx = tabController.index;
    currentTabIndex.value = idx;
    if (idx == 0) {
      onFilterProfit(item);
    } else {
      onFilterCarSelected(item);
    }
  }

  /// entry point for search bar (decide tab)
  void onSearch(String value) {
    final idx = tabController.index;
    currentTabIndex.value = idx;
    if (idx == 0) {
      onSearchProfit(value);
    } else {
      onSearchCar(value);
    }
  }

  void onFilterProfit(PopupDropdownModel item) {
    filterProfitPopup.selectedItem.value = item;
    searchController.text = "";

    final monthProfits = profitMatrix.value.toListMonthProfit();
    List<MonthProfit> filtered = monthProfits;

    switch (item.id) {
      case "highest":
        filtered = sortByProfitDesc(filtered);
        break;
      case "lowest":
        filtered = sortByProfitAsc(filtered);
        break;
      case "newest":
        filtered = sortByNewest(filtered);
        break;
      case "oldest":
        filtered = sortByOldest(filtered);
        break;
      default:
        filtered = monthProfits;
        break;
    }

    originListMonthProfit.value = filtered;
    listMonthProfit.value = filtered;
    update(["TAB_BAR_ID"]);
  }

  /// Filter/sort danh sách xe (dùng originSoldList làm nguồn)
  void onFilterCarSelected(PopupDropdownModel item) {
    filterCarPopup.selectedItem.value = item;

    final base = [...originSoldList];
    List<CarModel> filteredList = base;

    switch (item.id) {
      case 'profit_highest':
        filteredList.sort((a, b) => (b.profit ?? 0).compareTo(a.profit ?? 0));
        break;
      case 'profit_lowest':
        filteredList.sort((a, b) => (a.profit ?? 0).compareTo(b.profit ?? 0));
        break;
      case 'soldValue_highest':
        filteredList
            .sort((a, b) => (b.soldPrice ?? 0).compareTo(a.soldPrice ?? 0));
        break;
      case 'soldValue_lowest':
        filteredList
            .sort((a, b) => (a.soldPrice ?? 0).compareTo(b.soldPrice ?? 0));
        break;
      case 'all':
      default:
        // keep original order (base)
        break;
    }

    // update displayed soldList (UI reads profitMatrix.value.soldList)
    profitMatrix.update((val) {
      if (val != null) {
        val.soldList = [...filteredList];
      }
    });

    update(["TAB_BAR_ID"]);
  }

  void onSearchProfit(String keyword) {
    searchController.text = keyword.trim().toLowerCase();

    if (searchController.text.isEmpty) {
      listMonthProfit.value = originListMonthProfit;
    } else {
      final regex = RegExp(r'\d+');
      final matches = regex
          .allMatches(searchController.text)
          .map((e) => e.group(0)!)
          .toList();

      String? month;
      String? yearPrefix;

      for (var m in matches) {
        if (m.length == 4) {
          yearPrefix = m;
        } else if (m.length <= 2) {
          final numVal = int.tryParse(m);
          if (numVal != null && numVal >= 1 && numVal <= 12 && month == null) {
            month = numVal.toString();
          } else {
            yearPrefix = m;
          }
        }
      }

      listMonthProfit.value = originListMonthProfit.where((item) {
        final yearStr = item.year.toString();
        final monthStr = item.month.toString();

        bool matchYear = true;
        bool matchMonth = true;

        if (yearPrefix != null) {
          matchYear = yearPrefix.length == 4
              ? yearStr == yearPrefix
              : yearStr.startsWith(yearPrefix);
        }
        if (month != null) {
          matchMonth = monthStr == month;
        }
        return matchYear && matchMonth;
      }).toList();
    }
    update(["TAB_BAR_ID"]);
  }

  /// Search car theo tên hoặc biển số (tìm tên trước, nếu ko có thì tìm biển số)
  void onSearchCar(String keyword) {
    final q = keyword.trim().toLowerCase();
    searchController.text = q;

    // always search using originSoldList (full data)
    final base = [...originSoldList];

    if (q.isEmpty) {
      profitMatrix.update((val) {
        if (val != null) val.soldList = [...base];
      });
      update(["TAB_BAR_ID"]);

      return;
    }

    // 1) tìm theo name
    final byName = base.where((car) {
      final name = (car.name ?? "").toLowerCase();
      return name.contains(q);
    }).toList();

    if (byName.isNotEmpty) {
      profitMatrix.update((val) {
        if (val != null) val.soldList = [...byName];
      });
      update(["TAB_BAR_ID"]);

      return;
    }

    // 2) fallback: tìm theo plate
    final byPlate = base.where((car) {
      final plate = (car.plate ?? "").toLowerCase();
      return plate.contains(q);
    }).toList();

    profitMatrix.update((val) {
      if (val != null) val.soldList = [...byPlate];
    });
    update(["TAB_BAR_ID"]);
  }

  // ===============================
  // Sort Helpers
  // ===============================
  List<MonthProfit> sortByProfitDesc(List<MonthProfit> list) =>
      [...list]..sort((a, b) => b.profit.compareTo(a.profit));

  List<MonthProfit> sortByProfitAsc(List<MonthProfit> list) =>
      [...list]..sort((a, b) => a.profit.compareTo(b.profit));

  List<MonthProfit> sortByNewest(List<MonthProfit> list) => [...list]..sort((a,
          b) =>
      b.year != a.year ? b.year.compareTo(a.year) : b.month.compareTo(a.month));

  List<MonthProfit> sortByOldest(List<MonthProfit> list) => [...list]..sort((a,
          b) =>
      a.year != b.year ? a.year.compareTo(b.year) : a.month.compareTo(b.month));

  // ===============================

  // Static Helpers
  // ===============================
  static List<ItemModel> _yearItems() {
    final currentYear = DateTime.now().year;
    return [
      ItemModel(id: "", title: "Tất cả"),
      for (int y = currentYear; y >= 2018; y--)
        ItemModel(id: "$y", title: "Năm $y"),
    ];
  }

  static List<ItemModel> _monthItems() {
    return [
      ItemModel(id: "", title: "Tất cả"),
      for (int m = 1; m <= 12; m++) ItemModel(id: "$m", title: "Tháng $m"),
    ];
  }
}

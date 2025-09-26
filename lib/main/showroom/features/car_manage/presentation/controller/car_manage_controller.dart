import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/sort_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarManageController extends GetxController {
  // ---------------------------------------------------------------------------
  // Dependencies
  // ---------------------------------------------------------------------------
  final CarUsecase _carUsecase;
  CarManageController(this._carUsecase);

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------
  final cars = <CarModel>[].obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final isRefreshing = false.obs;
  final errorMessage = ''.obs;

  final searchText = ''.obs;
  final headerTabSelectedIndex = 0.obs;
  final inventoryValue = 0.0.obs;
  final profit = 0.0.obs;
  final soldValue = 0.0.obs;

  static const int _pageSize = 8;
  String? _nextPageToken;
  final List<CarModel> _allShowroomCars = [];

  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------
  final scrollController = ScrollController();
  final sortController = SortController();

  final filterCarPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả xe'),
      PopupDropdownModel(id: 'Xe mới nhập', label: 'Xe mới nhập'),
      PopupDropdownModel(id: 'Xe đem đi dọn', label: 'Xe đem đi dọn'),
      PopupDropdownModel(id: 'Xe đã cọc', label: 'Xe đã cọc'),
      PopupDropdownModel(id: 'Xe đang ở Auto', label: 'Xe đang ở Auto'),
      PopupDropdownModel(id: 'Xe đã bán', label: 'Xe đã bán'),
    ].obs,
  );

  final filterCarInShowRoomPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả xe'),
      PopupDropdownModel(id: 'Xe mới nhập', label: 'Xe mới nhập'),
      PopupDropdownModel(id: 'Xe đem đi dọn', label: 'Xe đem đi dọn'),
      PopupDropdownModel(id: 'Xe đã cọc', label: 'Xe đã cọc'),
      PopupDropdownModel(id: 'Xe đang ở Auto', label: 'Xe đang ở Auto'),
    ].obs,
  );

  final filterSoldCarPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả xe'),
      PopupDropdownModel(id: 'Xe đã bán', label: 'Xe đã bán'),
    ].obs,
  );

  final headerTabItem = [
    ItemModel(id: 'all', title: 'Tất cả xe'),
    ItemModel(id: 'in_stock', title: 'Xe ở Showroom'),
    ItemModel(id: 'sold', title: 'Xe đã bán'),
  ];

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void onReady() {
    super.onReady();
    fetchCars();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    filterCarPopup.dispose();
    filterCarInShowRoomPopup.dispose();
    filterSoldCarPopup.dispose();
    super.onClose();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  void _setLoadingState({required bool loading, bool loadMore = false}) {
    if (loadMore) {
      isLoadMore.value = loading;
    } else {
      isLoading.value = loading;
    }
  }

  void _handleError(Object e, StackTrace stack, String fn) {
    errorMessage.value = e.toString();
    debugPrint('❌ $fn lỗi: $e\n$stack');
  }

  PopupDropdownController _getPopupByTab() {
    switch (headerTabSelectedIndex.value) {
      case 1:
        return filterCarInShowRoomPopup;
      case 2:
        return filterSoldCarPopup;
      default:
        return filterCarPopup;
    }
  }

  String? _getCurrentStatus() {
    final id = _getPopupByTab().selectedItem.value.id;
    return id == 'all' ? null : id;
  }

  void _onScroll() {
    final nearBottom = scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100;
    if (!nearBottom || isLoadMore.value || _nextPageToken == null) return;

    switch (headerTabSelectedIndex.value) {
      case 2:
        fetchSoldCars(loadMore: true);
        break;
      default:
        fetchCars(loadMore: true);
    }
  }

  // ---------------------------------------------------------------------------
  // API calls
  // ---------------------------------------------------------------------------

  Future<void> fetchCars({bool loadMore = false}) async {
    _setLoadingState(loading: true, loadMore: loadMore);
    if (!loadMore) _nextPageToken = null;

    try {
      print(">>> ${sortController.sortType}");
      final isSearching = searchText.value.isNotEmpty;
      final result = isSearching
          ? await _carUsecase.searchCars(
              name: searchText.value,
              status: _getCurrentStatus(),
              pageSize: _pageSize,
              pageToken: loadMore ? _nextPageToken : null,
            )
          : await _carUsecase.getCars(
              status: _getCurrentStatus(),
              pageSize: _pageSize,
              pageToken: loadMore ? _nextPageToken : null,
              sortType:
                  sortController.isAsc ? SortType.newest : SortType.oldest,
            );

      if (loadMore) {
        cars.addAll(result.items);
      } else {
        cars.assignAll(result.items);
      }
      _nextPageToken = result.nextPageToken;
      errorMessage.value = '';
    } catch (e, stack) {
      _handleError(e, stack, 'fetchCars');
    } finally {
      _setLoadingState(loading: false, loadMore: loadMore);
      isRefreshing.value = false;
    }
  }

  Future<void> fetchSoldCars({bool loadMore = false}) async {
    _setLoadingState(loading: true, loadMore: loadMore);
    if (!loadMore) _nextPageToken = null;

    try {
      final result = await _carUsecase.call(
        pageSize: _pageSize,
        pageToken: loadMore ? _nextPageToken : null,
      );

      profit.value = result.totals?.profit ?? 0;
      soldValue.value = result.totals?.soldValue ?? 0;
      final items = result.items ?? [];

      if (loadMore) {
        cars.addAll(items);
      } else {
        cars.assignAll(items);
      }
      _nextPageToken = result.nextPageToken;
      errorMessage.value = '';
    } catch (e, stack) {
      _handleError(e, stack, 'fetchSoldCars');
    } finally {
      _setLoadingState(loading: false, loadMore: loadMore);
      isRefreshing.value = false;
    }
  }

  Future<void> fetchShowroomCars() async {
    isLoading.value = true;
    try {
      final res = await _carUsecase.getShowroomCars();
      _allShowroomCars
        ..clear()
        ..addAll(res.items ?? []);
      cars.assignAll(_allShowroomCars);
      inventoryValue.value = res.inventoryValue ?? 0;
      errorMessage.value = '';
    } catch (e, stack) {
      _handleError(e, stack, 'fetchShowroomCars');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // UI actions
  // ---------------------------------------------------------------------------

  void onSearchShowroomCars(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      cars.assignAll(_allShowroomCars);
      return;
    }
    final lower = query.toLowerCase();
    cars.assignAll(
      _allShowroomCars.where(
        (e) =>
            (e.name ?? '').toLowerCase().contains(lower) ||
            (e.plate ?? '').toLowerCase().contains(lower) ||
            (e.brand ?? '').toLowerCase().contains(lower),
      ),
    );
  }

  Future<void> refreshCars() async {
    isRefreshing.value = true;
    _nextPageToken = null;
    switch (headerTabSelectedIndex.value) {
      case 1:
        await fetchShowroomCars();
        break;
      case 2:
        await fetchSoldCars();
        break;
      default:
        await fetchCars();
    }
  }

  Future<void> onToDetailCar(CarModel arguments) async {
    bool result = await Get.toNamed(
      const CarDetailPage().routeName,
      arguments: arguments,
    );
    if (result) {
      refreshCars();
    }
  }

  Future<void> onSetSelectedHeaderTab(int index) async {
    if (headerTabSelectedIndex.value == index) return;
    headerTabSelectedIndex.value = index;
    searchText.value = '';
    sortController.resetSort();
    _nextPageToken = null;

    switch (index) {
      case 1:
        await fetchShowroomCars();
        break;
      case 2:
        await fetchSoldCars();
        break;
      default:
        await fetchCars();
    }
    update(['HEADER_MANAGE_CAR_ID']);
  }

  void onSort() {
    if (headerTabSelectedIndex.value == 0) {
      sortController.toggleSort();
      fetchCars();
      return;
    }
    if (headerTabSelectedIndex.value == 1) {
      sortController.toggleSort();
      final asc = !sortController.isAsc;
      cars.sort((a, b) {
        final aDate = a.importDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.importDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        return asc ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
      });
    }
  }

  void onFilterChanged() {
    if (headerTabSelectedIndex.value == 1) {
      final status = _getCurrentStatus();
      cars.assignAll(
        status == null
            ? _allShowroomCars
            : _allShowroomCars.where((e) => e.status == status).toList(),
      );
    } else {
      _nextPageToken = null;
      headerTabSelectedIndex.value == 2 ? fetchSoldCars() : fetchCars();
    }
  }
}

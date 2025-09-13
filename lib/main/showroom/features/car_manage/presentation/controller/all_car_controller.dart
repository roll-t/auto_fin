import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/sort_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarController extends GetxController {
  final CarUsecase _carUsecase;
  AllCarController(this._carUsecase);

  /// State
  final cars = <CarModel>[].obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final isRefreshing = false.obs;
  final errorMessage = ''.obs;
  final selectedIndex = 0.obs;
  final searchText = ''.obs;

  /// Token phân trang
  String? _nextPageToken;

  /// Scroll & filter/sort
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

  /// Danh sách tab trên UI
  // final items = const ["Tất cả xe", "Xe đã bán", "Xe ở Auto"];

  @override
  void onReady() {
    super.onReady();
    fetchCars();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoadMore.value &&
        _nextPageToken != null) {
      fetchCars(loadMore: true);
    }
  }

  /// Xác định `status` theo tab/filter
  String? _getCurrentStatus() {
    final id = filterCarPopup.selectedItem.value.id;
    return id == 'all' ? null : id;
  }

  /// Lấy danh sách xe
  Future<void> fetchCars({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      if (!loadMore) _nextPageToken = null;
    }

    try {
      final bool isSearching = searchText.value.isNotEmpty;

      final result = isSearching
          ? await _carUsecase.searchCars(
              name: searchText.value,
              // plate: searchText.value,
              status: _getCurrentStatus(),
              // all: false,
              pageSize: 8,
              pageToken: loadMore ? _nextPageToken : null,
            )
          : await _carUsecase.getCars(
              pageSize: 8,
              pageToken: loadMore ? _nextPageToken : null,
              status: _getCurrentStatus(),
            );

      if (loadMore) {
        cars.addAll(result.items);
      } else {
        cars.assignAll(result.items);
      }
      _nextPageToken = result.nextPageToken;
      errorMessage.value = '';
    } catch (e, stack) {
      errorMessage.value = e.toString();
      debugPrint('❌ fetchCars lỗi: $e\n$stack');
    } finally {
      if (loadMore) {
        isLoadMore.value = false;
      } else {
        isLoading.value = false;
        isRefreshing.value = false;
      }
    }
  }

  /// Làm mới danh sách
  Future<void> refreshCars() async {
    isRefreshing.value = true;
    _nextPageToken = null;
    await fetchCars(loadMore: false);
  }

  /// Đổi tab trên header
  void setSelected(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
    _nextPageToken = null;
    fetchCars();
  }

  /// Đổi filter popup
  void onFilterChanged() {
    _nextPageToken = null;
    fetchCars();
  }

  @override
  void onClose() {
    scrollController.dispose();
    filterCarPopup.dispose();
    super.onClose();
  }
}

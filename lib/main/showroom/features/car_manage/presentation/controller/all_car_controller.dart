import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/sort_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarController extends GetxController {
  /// Dependency
  final CarUsecase _carUsecase;
  AllCarController(this._carUsecase);

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

  String? _nextPageToken;

  final List<CarModel> _allShowroomCars = [];

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

  final List<ItemModel> headerTabItem = [
    ItemModel(id: 'all', title: 'Tất cả xe'),
    ItemModel(id: 'in_stock', title: 'Xe ở Showroom'),
    ItemModel(id: 'sold', title: 'Xe đã bán'),
  ];

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
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoadMore.value &&
        _nextPageToken != null) {
      if (headerTabSelectedIndex.value == 2) {
        fetchSoldCars(loadMore: true);
      } else {
        fetchCars(loadMore: true);
      }
    }
  }

  String? _getCurrentStatus() {
    String id = "";
    if (headerTabSelectedIndex.value == 0) {
      id = filterCarPopup.selectedItem.value.id;
    } else if (headerTabSelectedIndex.value == 1) {
      id = filterCarInShowRoomPopup.selectedItem.value.id;
    } else if (headerTabSelectedIndex.value == 2) {
      id = filterSoldCarPopup.selectedItem.value.id;
    }
    return id == 'all' ? null : id;
  }

  // ---------------------------------------------------------------------------
  // API calls
  // ---------------------------------------------------------------------------

  Future<void> fetchCars({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      _nextPageToken = null;
    }

    try {
      final isSearching = searchText.value.isNotEmpty;
      final result = isSearching
          ? await _carUsecase.searchCars(
              name: searchText.value,
              status: _getCurrentStatus(),
              pageSize: 8,
              pageToken: loadMore ? _nextPageToken : null,
            )
          : await _carUsecase.getCars(
              status: _getCurrentStatus(),
              pageSize: 8,
              pageToken: loadMore ? _nextPageToken : null,
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
      isLoadMore.value = false;
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  /// ✅ Lấy danh sách xe đã bán
  Future<void> fetchSoldCars({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      _nextPageToken = null;
    }

    try {
      final result = await _carUsecase.call(
        pageSize: 8,
        pageToken: loadMore ? _nextPageToken : null,
      );
      profit.value = result.totals?.profit ?? 0;
      soldValue.value = result.totals?.soldValue ?? 0;
      if (loadMore) {
        cars.addAll(result.items ?? []);
      } else {
        cars.assignAll(result.items ?? []);
      }

      _nextPageToken = result.nextPageToken;
      errorMessage.value = '';
    } catch (e, stack) {
      errorMessage.value = e.toString();
      debugPrint('❌ fetchSoldCars lỗi: $e\n$stack');
    } finally {
      isLoadMore.value = false;
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  Future<void> fetchShowroomCars() async {
    isLoading.value = true;
    try {
      final response = await _carUsecase.getShowroomCars();

      _allShowroomCars
        ..clear()
        ..addAll(response.items ?? []);

      cars.assignAll(_allShowroomCars);
      inventoryValue.value = response.inventoryValue ?? 0;
      errorMessage.value = '';
    } catch (e, stack) {
      errorMessage.value = e.toString();
      debugPrint('❌ fetchShowroomCars lỗi: $e\n$stack');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // UI actions
  // ---------------------------------------------------------------------------

  Future<void> refreshCars() async {
    isRefreshing.value = true;
    _nextPageToken = null;
    if (headerTabSelectedIndex.value == 2) {
      await fetchSoldCars();
    } else {
      await fetchCars();
    }
  }

  void onSetSelectedHeaderTab(int index) async {
    if (headerTabSelectedIndex.value == index) return;

    headerTabSelectedIndex.value = index;
    _nextPageToken = null;

    if (index == 0) {
      await fetchCars();
    } else if (index == 1) {
      await fetchShowroomCars();
    } else if (index == 2) {
      await fetchSoldCars();
    }

    update(["HEADER_MANAGE_CAR_ID"]);
  }

  void onFilterChanged() {
    if (headerTabSelectedIndex.value == 1) {
      final status = _getCurrentStatus();
      if (status == null) {
        cars.assignAll(_allShowroomCars);
      } else {
        cars.assignAll(
          _allShowroomCars.where((e) => e.status == status).toList(),
        );
      }
    } else {
      _nextPageToken = null;
      if (headerTabSelectedIndex.value == 2) {
        fetchSoldCars();
      } else {
        fetchCars();
      }
    }
  }
}

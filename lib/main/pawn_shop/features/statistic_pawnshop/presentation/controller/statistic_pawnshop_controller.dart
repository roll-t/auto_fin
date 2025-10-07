import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:get/get.dart';

class StatisticPawnshopController extends GetxController {
  ///============================== [VARIABLES] ==============================
  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;

  final BottomSheetController currencyUnitControllerV1 = BottomSheetController(
    listItem: [
      ItemModel(id: "vnd", title: "VND"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "vnd", title: "VND"),
  );

  final BottomSheetController currencyUnitControllerV2 = BottomSheetController(
    listItem: [
      ItemModel(id: "vnd", title: "VND"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "vnd", title: "VND"),
  );

  ///============================== [LIFECYCLE] ==============================
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    currencyUnitControllerV1.dispose();
    currencyUnitControllerV2.dispose();
  }

  void onCurrencyUnitChangedV1(ItemModel item) {
    currencyUnitControllerV1.itemSelected.value = item;
  }

  void onCurrencyUnitChangedV2(ItemModel item) {
    currencyUnitControllerV2.itemSelected.value = item;
  }
}

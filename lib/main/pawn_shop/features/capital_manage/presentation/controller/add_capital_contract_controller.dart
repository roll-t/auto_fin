import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:get/get.dart';

class AddCapitalContractController extends GetxController {
  ///============================== [VARIABLES] ==============================

  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final RxBool isPrepaidInterest = false.obs;

  final BottomSheetController customerType = BottomSheetController(
    listItem: [
      ItemModel(id: "new", title: "Khách hàng mới"),
      ItemModel(id: "old", title: "Khách hàng cũ"),
    ].obs,
    itemSelected: ItemModel(id: "new", title: "Khách hàng mới"),
  );

  final BottomSheetController interestRateType = BottomSheetController(
    listItem: [
      ItemModel(id: "month", title: "Lãi suất theo tháng"),
      ItemModel(id: "day", title: "Lãi suất theo ngày"),
    ].obs,
    itemSelected: ItemModel(id: "month", title: "Lãi suất theo tháng"),
  );

  ///============================== [LIFECYCLE] ==============================
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

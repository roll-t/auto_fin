import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/utils/mixin_controller/argument_handle_mixin_controller.dart';
import 'package:auto_find/main/pawn_shop/data/model/history_income_expenditure_arg.dart';
import 'package:get/get.dart';

class HistoryIncomeExpenditureController extends GetxController
    with ArgumentHandlerMixinController<HistoryIncomeExpenditureArg> {
  ///============================== [VARIABLES] ==============================

  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final RxString titlePage = ''.obs;

  final BottomSheetController filterCapital = BottomSheetController(
    listItem: [
      ItemModel(id: "all", title: "Thu khác"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "all", title: "Thu khác"),
  );

  ///============================== [LIFECYCLE] ==============================
  @override
  void onInit() {
    super.onInit();
    bool hasData = handleArgumentFromGet();
    if (hasData) {
      titlePage.value = argsData?.isIncome == true
          ? "Lịch sử lập phiếu thu"
          : "Lịch sử lập phiếu chi";
      update(["TITLE_PAGE_ID"]);
    }
  }
}

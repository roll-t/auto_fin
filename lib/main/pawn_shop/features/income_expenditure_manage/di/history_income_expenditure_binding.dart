import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/controller/history_income_expenditure_controller.dart';
import 'package:get/get.dart';

class HistoryIncomeExpenditureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryIncomeExpenditureController());
  }
}

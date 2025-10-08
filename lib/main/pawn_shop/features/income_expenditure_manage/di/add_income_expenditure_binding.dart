import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/controller/add_income_expenditure_controller.dart';
import 'package:get/get.dart';

class AddIncomeExpenditureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddIncomeExpenditureController());
  }
}

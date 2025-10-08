import 'package:auto_find/main/pawn_shop/features/capital_manage/presentation/controller/add_capital_contract_controller.dart';
import 'package:get/get.dart';

class AddCapitalContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCapitalContractController());
  }
}

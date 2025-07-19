import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:get/get.dart';

class DiamondController extends GetxController {
  final List<ItemMenuFeatureModel> listDiamondFeature = [
    ItemMenuFeatureModel(
      title: "Nhập - Xuất\n Vàng",
      iconUrl: AppIcons.icExportGold,
    ),
    ItemMenuFeatureModel(
      title: "Vàng tồn kho",
      iconUrl: AppIcons.icGoldInventory,
    ),
    ItemMenuFeatureModel(
      title: "Giao dịch bán lẻ",
      iconUrl: AppIcons.icRetail,
    ),
    ItemMenuFeatureModel(
      title: "Dòng tiền theo ngày",
      iconUrl: AppIcons.icFlowMoney,
    ),
  ];
}

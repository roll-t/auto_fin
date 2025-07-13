import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/all_car_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_in_auto_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/vehicle_page.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/page/profit_manage_page.dart';
import 'package:get/get.dart';

class ShowroomController extends GetxController {
  final List<ItemMenuFeatureModel> listShowroomFeature = [
    ItemMenuFeatureModel(
      title: "Quản lý lợi nhuận",
      iconUrl: AppIcons.icProfig,
      routeNameUrl: ProfitManagePage.routeName,
    ),
    ItemMenuFeatureModel(
      title: "Toàn bộ xe",
      iconUrl: AppIcons.icAllCar,
      routeNameUrl: AllCarPage.routeName,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý xe ở Auto",
      iconUrl: AppIcons.icCarInGaga,
      routeNameUrl: CarInAutoPage.routeName,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý xe bán",
      iconUrl: AppIcons.icCarBuy,
      routeNameUrl: VehiclePage.routeName,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý danh mục xe",
      iconUrl: AppIcons.icCarCategory,
      routeNameUrl: "/",
    ),
  ];
}

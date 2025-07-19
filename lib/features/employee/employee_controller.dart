import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController{

    final List<ItemMenuFeatureModel> listEmployeeFeature = [
    ItemMenuFeatureModel(
      title: "Theo dõi lương",
      iconUrl: AppIcons.icSalary,
    ),
    ItemMenuFeatureModel(
      title: "Chấm công",
      iconUrl: AppIcons.icAttendance,
    ),
    ItemMenuFeatureModel(
      title: "Hoa hồng",
      iconUrl: AppIcons.icRose,
    ),
  ];
}
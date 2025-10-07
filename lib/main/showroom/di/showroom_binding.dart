import 'package:auto_find/main/showroom/data/repositories/brand_car_repository.dart';
import 'package:auto_find/main/showroom/data/repositories/car_repository.dart';
import 'package:auto_find/main/showroom/data/repositories/color_repository.dart';
import 'package:auto_find/main/showroom/data/repositories/type_car_repository.dart';
import 'package:auto_find/main/showroom/data/usecase/brand_product_usecase.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:auto_find/main/showroom/data/usecase/color_uscase.dart';
import 'package:auto_find/main/showroom/data/usecase/type_car_usecase.dart';
import 'package:auto_find/main/showroom/controller/dropdown_data_car_feature_controller.dart';
import 'package:get/get.dart';

class ShowroomBinding extends Bindings {
  @override
  void dependencies() {
    /// [REPOSITORY]
    Get.lazyPut(
      () => CarRepository(),
      fenix: true,
    );

    Get.lazyPut(
      () => BrandCarRepository(),
      fenix: true,
    );
    Get.lazyPut(
      () => TypeCarRepository(),
      fenix: true,
    );
    Get.lazyPut(
      () => ColorRepository(),
      fenix: true,
    );

    /// [USECASE]
    Get.lazyPut(
      () => CarUsecase(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => BrandProductUsecase(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => TypeCarUsecase(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => ColorUsecase(Get.find()),
      fenix: true,
    );

    /// [USECASE]
    Get.put(
      DropdownDataCarFeatureController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      permanent: true,
    );
  }
}

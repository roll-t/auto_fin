// ignore: file_names
import 'package:auto_find/main/setting/presentation/controller/setting_controller.dart';
import 'package:auto_find/main/user/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(), permanent: true);
    Get.put(SettingController(), permanent: true);
  }
}

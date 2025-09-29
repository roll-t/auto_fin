import 'package:auto_find/core/local_storage/app_get_storage.dart';
import 'package:auto_find/main/user/data/model/user_model.dart';
import 'package:auto_find/main/user/features/auth/login/presentation/page/login_page.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onReady() {
    super.onReady();
    user.value = AppGetStorage.getUser();
  }

  void onLogOut() {
    AppGetStorage.clearAuth();
    user.value = null;
    Get.offAllNamed(const LoginPage().routeName);
  }
}


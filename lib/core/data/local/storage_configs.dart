import 'package:auto_fin/core/data/local/app_get_storage.dart';

Future<void> storageConfigs() async {
  await AppGetStorage.init();
  AppGetStorage.printCacheSize();
}

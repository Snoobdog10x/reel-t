import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';
import 'package:reel_t/shared_product/services/local_user.dart';

class AppStore {
  LocalStorage localStorage = LocalStorage();
  LocalUser localUser = LocalUser();
  CloudStorage cloudStorage = CloudStorage();
  Future<void> init() async {
    await localStorage.init();
    localUser.init(localStorage);
  }
}

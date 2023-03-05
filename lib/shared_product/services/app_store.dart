import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:reel_t/shared_product/services/local_user.dart';

class AppStore {
  LocalUser localUser = LocalUser();
  CloudStorage cloudStorage = CloudStorage();
}

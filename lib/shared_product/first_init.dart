import 'package:reel_t/shared_product/services/app_store.dart';

class FirstInit {
  static final AppStore appStore = AppStore();
  Future<void> init() async {
    await appStore.init();
  }
}

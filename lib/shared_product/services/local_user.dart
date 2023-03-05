import 'dart:html';

import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

class LocalUser {
  LocalStorage storage = LocalStorage();
  LocalUser() {
    storage.init();
  }

  void login(UserProfile userProfile) {
    storage.setCache(
      LocalStorage.SIGNED_IN_USER_CACHE_KEY,
      userProfile.toStringJson(),
    );
  }

  void logout() {
    storage.removeCache(LocalStorage.SIGNED_IN_USER_CACHE_KEY);
  }
}

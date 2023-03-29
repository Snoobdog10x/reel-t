import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

class LocalUser {
  late LocalStorage storage;
  void init(LocalStorage storage) {
    this.storage = storage;
  }

  UserProfile getCurrentUser() {
    var stringJsonUser =
        storage.getCache(LocalStorage.SIGNED_IN_USER_CACHE_KEY);
    if (stringJsonUser.isEmpty) {
      return UserProfile();
    }
    print(UserProfile.fromStringJson(stringJsonUser));
    var userProfile = UserProfile.fromStringJson(stringJsonUser);
    return userProfile;
  }

  bool isLogin() {
    return storage.getCache(LocalStorage.SIGNED_IN_USER_CACHE_KEY).isEmpty;
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

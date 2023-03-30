import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

class LocalUser {
  late Box<UserProfile> userBox;
  String LOCAL_USER_PATH = UserProfile.PATH + "_local";
  Future<void> init() async {
    userBox = await Hive.openBox(LOCAL_USER_PATH);
  }

  UserProfile getCurrentUser() {
    if (!isLogin()) {
      return UserProfile(fullName: "Guest");
    }
    
    List<UserProfile> userProfiles = userBox.values.toList();
    return userProfiles.first;
  }

  bool isLogin() {
    return userBox.isEmpty;
  }

  void login(UserProfile userProfile) {
    userBox.add(userProfile);
    userProfile.save();
  }

  void logout() {
    if (!isLogin()) return;
    userBox.getAt(0)!.delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/setting/setting.dart';

abstract class RetrieveUserSettingEvent {
  Future<void> sendRetrieveUserSettingEvent(String userId) async {
    try {
      var setting = await _retrieveUserSetting(userId);
      onRetrieveUserSettingEventDone(setting);
    } catch (e) {
      print(e);
      onRetrieveUserSettingEventDone(null);
    }
  }

  Future<Setting> _retrieveUserSetting(String userId) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Setting.PATH)
        .limit(1);

    var snapshot = await db.get();

    return Setting.fromJson(snapshot.docs.first.data());
  }

  void onRetrieveUserSettingEventDone(Setting? setting);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../models/setting/setting.dart';
import '../../../models/user_profile/user_profile.dart';

abstract class CreateUserSettingEvent {
  Future<void> sendCreateUserSettingEvent(String userId) async {
    try {
      var setting = await _createUserSetting(userId);
      onCreateUserSettingEventDone(setting);
    } catch (e) {
      print(e);
      onCreateUserSettingEventDone(null);
    }
  }

  Future<Setting?> _retrieveUserSetting(String userId) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Setting.PATH)
        .limit(1);

    var snapshot = await db.get();
    if (snapshot.docs.isEmpty) return null;

    return Setting.fromJson(snapshot.docs.first.data());
  }

  Future<Setting> _createUserSetting(String userId) async {
    var setting = await _retrieveUserSetting(userId);
    if (setting != null) return setting;

    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Setting.PATH);
    var doc = db.doc();
    var newSetting = Setting(
      id: doc.id,
      userId: userId,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
      updateAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    await doc.set(newSetting.toJson());

    return newSetting;
  }

  void onCreateUserSettingEventDone(Setting? setting);
}

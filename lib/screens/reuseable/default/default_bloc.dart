import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/events/setting/create_user_setting/create_user_setting_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/events/user/user_sign_up/user_sign_up_event.dart';
import 'package:reel_t/models/setting/setting.dart';

import '../../../events/user/user_sign_in/user_sign_in_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'default_screen.dart';

class DefaultBloc extends AbstractBloc<DefaultScreenState>
    with CreateUserSettingEvent {
  void init() {}

  Future<void> loginUser(UserProfile userProfile) async {
    // final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    // db.doc(userProfile.id).set(userProfile.toJson());
    sendCreateUserSettingEvent(userProfile.id);
    await appStore.localUser.logout();
    await appStore.localUser.login(userProfile);
    appStore.receiveNotification.setNotificationStream(userProfile.id);
  }

  @override
  void onCreateUserSettingEventDone(Setting? setting) {
    if (setting != null) appStore.localSetting.setUserSetting(setting);
  }
}

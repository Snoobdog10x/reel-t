import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/setting/setting.dart';
import 'security_setting_and_privacy_screen.dart';

class SecuritySettingAndPrivacyBloc
    extends AbstractBloc<SecuritySettingAndPrivacyScreenState> {
  // late Setting localSetting;
  late UserProfile currentUser;
  Future<void> init() async {
    currentUser = appStore.localUser.getCurrentUser();
    // localSetting =
    //     (await appStore.localSetting.getUserSetting(currentUser.id))!;
    // state.switchValue = localSetting.isTurnOffTwoFa;
  }

  bool getIsTurnOffTwoFa() {
    var db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(currentUser.id)
        .collection(Setting.PATH);
    return false;
  }
}

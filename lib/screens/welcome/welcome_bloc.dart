import 'package:reel_t/events/setting/retrieve_user_setting/retrieve_user_setting_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/models/setting/setting.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/welcome/welcome_screen.dart';

import '../../generated/abstract_bloc.dart';
import '../navigation/navigation_screen.dart';

class WelcomeBloc extends AbstractBloc<WelcomeScreenState>
    with RetrieveUserProfileEvent, RetrieveUserSettingEvent {
  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile == null) {
      state.pushToScreen(NavigationScreen(), isReplace: true);
      return;
    }
    appStore.localUser.login(userProfile);
    sendRetrieveUserSettingEvent(userProfile.id);
  }

  @override
  void onRetrieveUserSettingEventDone(Setting? setting) {
    if (setting != null) appStore.localSetting.setUserSetting(setting);
    state.pushToScreen(NavigationScreen(), isReplace: true);
  }
}

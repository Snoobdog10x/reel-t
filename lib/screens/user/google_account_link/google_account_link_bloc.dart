import 'package:camerawesome/generated/i18n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel_t/events/setting/create_user_setting/create_user_setting_event.dart';
import 'package:reel_t/events/user/google_sign_up/link_credential/link_credential_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/events/user/update_user_profile/update_user_profile_event.dart';
import 'package:reel_t/events/user/user_sign_in/user_sign_in_event.dart';
import 'package:reel_t/events/user/user_sign_up/user_sign_up_event.dart';
import 'package:reel_t/models/setting/setting.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/navigation/navigation_screen.dart';

import '../../../generated/abstract_bloc.dart';
import 'google_account_link_screen.dart';

class GoogleAccountLinkBloc extends AbstractBloc<GoogleAccountLinkScreenState>
    with
        UserSignInEvent,
        LinkCredentialEvent,
        UpdateUserProfileEvent,
        RetrieveUserProfileEvent,
        CreateUserSettingEvent,
        UserSignUpEvent {
  UserProfile? signedInUserProfile;
  late GoogleSignInAccount googleSignInAccount;
  String hashedPassword = "";
  void init(GoogleSignInAccount googleSignInAccount) {
    this.googleSignInAccount = googleSignInAccount;
    sendRetrieveUserProfileEvent(email: googleSignInAccount.email);
    notifyDataChanged();
  }

  void authenticate(String password) {
    hashedPassword = appStore.security.hashPassword(password);
    var email = googleSignInAccount.email;
    if (state.widget.isLinkAccountWithEmail) {
      sendUserSignInEvent(email, hashedPassword);
      return;
    }

    sendUserSignUpEvent(email: email, password: hashedPassword);
  }

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    state.stopLoading();
    if (e.isEmpty) {
      this.signedInUserProfile = signedInUserProfile!;
      sendLinkCredentialEvent(googleSignInAccount);
      return;
    }

    state.showAlertDialog(
      title: "Login",
      content: e,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  @override
  void onLinkCredentialEventDone(String e) {
    if (e.isNotEmpty) {
      state.showAlertDialog(
        title: "Login",
        content: e,
        confirm: () {
          state.popTopDisplay();
        },
      );
      return;
    }
    if (state.widget.isLinkAccountWithEmail) {
      state.stopLoading();
      signedInUserProfile!.signUpType = SignUpType.BOTH_EMAIL_GOOGLE.index;
      sendUpdateUserProfileEvent(signedInUserProfile!);
      appStore.localUser.login(signedInUserProfile!);
      appStore.localSetting.syncUserSetting(signedInUserProfile!.id);
      state.pushToScreen(NavigationScreen(), isReplace: true);
      return;
    }

    signedInUserProfile!.signUpType = SignUpType.BOTH_EMAIL_GOOGLE.index;
    sendUpdateUserProfileEvent(signedInUserProfile!);
    sendCreateUserSettingEvent(signedInUserProfile!.id);
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {}

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    signedInUserProfile = userProfile;
  }

  @override
  void onCreateUserSettingEventDone(Setting? setting) {
    appStore.localUser.login(signedInUserProfile!);
    appStore.localSetting.syncUserSetting(signedInUserProfile!.id);
    state.pushToScreen(NavigationScreen(), isReplace: true);
  }

  @override
  void onUserSignUpEventDone(
      String errorMessage, UserProfile? signedUserProfile) {
    if (errorMessage.isEmpty) {
      sendLinkCredentialEvent(googleSignInAccount);
      signedInUserProfile = signedUserProfile;
      return;
    }

    state.showAlertDialog(
      title: "SignUp",
      content: errorMessage,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }
}

import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel_t/events/user/google_sign_up/link_credential/link_credential_event.dart';
import 'package:reel_t/events/user/update_user_profile/update_user_profile_event.dart';
import 'package:reel_t/events/user/user_sign_in/user_sign_in_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import '../../welcome/welcome_screen.dart';
import 'google_account_link_screen.dart';

class GoogleAccountLinkBloc extends AbstractBloc<GoogleAccountLinkScreenState>
    with UserSignInEvent, LinkCredentialEvent, UpdateUserProfileEvent {
  UserProfile? signedInUserProfile;
  late GoogleSignInAccount googleSignInAccount;
  void init(GoogleSignInAccount googleSignInAccount) {
    this.googleSignInAccount = googleSignInAccount;
    notifyDataChanged();
  }

  void authenticate(String password) {
    var hashedPassword = appStore.security.hashPassword(password);
    sendUserSignInEvent(googleSignInAccount.email, hashedPassword);
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
    if (e.isEmpty) {
      signedInUserProfile!.signUpType = SignUpType.BOTH.index;
      sendUpdateUserProfileEvent(signedInUserProfile!);
      appStore.localUser.login(signedInUserProfile!);
      appStore.localSetting.syncUserSetting(signedInUserProfile!.id);
      state.pushToScreen(WelcomeScreen(), isReplace: true);
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
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    // TODO: implement onUpdateUserProfileEventDone
  }
}

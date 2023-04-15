import 'package:reel_t/events/setting/retrieve_user_setting/retrieve_user_setting_event.dart';
import 'package:reel_t/events/user/google_sign_up/google_sign_up_event.dart';
import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import 'package:reel_t/models/setting/setting.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';

import '../../../events/user/user_sign_in/user_sign_in_event.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_bloc.dart';
import 'login_screen.dart';

class LoginBloc extends AbstractBloc<LoginScreenState>
    with
        UserSignInEvent,
        SendEmailOtpEvent,
        GoogleSignUpEvent,
        RetrieveUserSettingEvent {
  String email = "";
  String password = "";
  late UserProfile signedInUserProfile;
  void login() {
    var hashedPassword = appStore.security.hashPassword(password);
    sendUserSignInEvent(email, hashedPassword);
  }

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    if (e.isEmpty) {
      this.signedInUserProfile = signedInUserProfile!;
      sendRetrieveUserSettingEvent(signedInUserProfile.id);
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
  void onSendEmailOtpEventDone(bool isSent) {
    if (isSent) {
      state.stopLoading();
      state.pushToScreen(EmailAuthenticateScreen(
        email: signedInUserProfile.email,
        password: password,
        previousScreen: LoginScreenState.LOGIN_SCREEN,
      ));
    }
  }

  @override
  void onGoogleSignUpEventDone(e, signedUser) {
    state.stopLoading();
    if (e.isEmpty) {
      return;
    }
    if (e == "success") {
      appStore.localUser.login(signedUser!);
      appStore.localSetting.syncUserSetting(signedUser.id);
      state.popTopDisplay();
      appStore.globalNotifyDataChanged?.call();
      return;
    }
    state.showAlertDialog(
      title: "Sign-up",
      content: e,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  @override
  void onRetrieveUserSettingEventDone(Setting? setting) {
    if (setting != null) {
      if (setting.isTurnOffNotification) {
        state.stopLoading();
        appStore.localSetting.setUserSetting(setting);
        appStore.localUser.login(signedInUserProfile);
        state.popTopDisplay();
        return;
      }

      sendSendEmailOtpEvent(email);
      return;
    }
    sendSendEmailOtpEvent(email);
  }
}

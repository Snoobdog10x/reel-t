import 'dart:math';

import 'package:firebase_auth_platform_interface/src/providers/oauth.dart';
import 'package:reel_t/events/setting/create_user_setting/create_user_setting_event.dart';
import 'package:reel_t/events/user/google_sign_up/google_sign_up_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import 'package:reel_t/models/setting/setting.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_bloc.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';
import 'package:reel_t/screens/user/signup/signup_screen.dart';
import 'package:reel_t/shared_product/utils/validator/email_validator.dart';

import '../../../events/user/user_sign_up/user_sign_up_event.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_bloc.dart';

class SignupBloc extends AbstractBloc<SignupScreenState>
    with SendEmailOtpEvent, CreateUserSettingEvent, RetrieveUserProfileEvent {
  String email = "";
  String password = "";
  Future<void> signIn() async {
    state.startLoading();
    if (!EmailValidator().isValid(email)) {
      state.showAlertDialog(
        title: "Sign-up",
        content: "Email is not valid",
        confirm: () {
          state.popTopDisplay();
        },
      );
      return;
    }
    sendRetrieveUserProfileEvent(email: email);
  }

  @override
  void onSendEmailOtpEventDone(bool isSent) {
    if (isSent) {
      state.stopLoading();
      state.pushToScreen(
        EmailAuthenticateScreen(
          email: email.toLowerCase(),
          password: password,
          previousScreen: SignupScreenState.SIGN_UP_SCREEN,
        ),
      );

      return;
    }
    state.showAlertDialog(
      title: "Sign-up",
      content: "Server error, please try later",
      confirm: () {
        state.popTopDisplay();
      },
    );
    state.stopLoading();
  }

  @override
  void onCreateUserSettingEventDone(Setting? setting) {
    if (setting != null) appStore.localSetting.setUserSetting(setting);
    state.popTopDisplay();
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile != null) {
      state.showAlertDialog(
        title: "Sign-up",
        content: "User already exists",
        confirm: () {
          state.popTopDisplay();
        },
      );
      return;
    }
    
    sendSendEmailOtpEvent(email);
  }
}

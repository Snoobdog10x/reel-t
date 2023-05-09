import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import 'package:reel_t/events/user/user_sign_in/user_sign_in_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/sub_setting_user/reset_password/reset_password_screen.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';

import '../../../generated/abstract_bloc.dart';

class ResetPasswordBloc extends AbstractBloc<ResetPasswordScreenState>
    with UserSignInEvent, SendEmailOtpEvent {
  String currentPassword = "";
  late UserProfile currentUser;

  void init() {
    currentUser = appStore.localUser.getCurrentUser();
  }

  void verifyPassword() {
    state.startLoading();
    var hashedPassword = appStore.security.hashPassword(currentPassword);

    sendUserSignInEvent(currentUser.email, hashedPassword);
  }

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    if (e.isEmpty) {
      sendSendEmailOtpEvent(currentUser.email);
      return;
    }
    state.showAlertDialog(
        title: "Verification",
        content: e,
        confirm: () {
          state.popTopDisplay();
        });
  }

  @override
  void onSendEmailOtpEventDone(bool isSent) {
    if (isSent) {
      state.stopLoading();
      state.pushToScreen(EmailAuthenticateScreen(
        email: currentUser.email,
        previousScreen: ResetPasswordScreenState.RESET_PASSWORD_SCREEN,
      ));
    }
  }
}

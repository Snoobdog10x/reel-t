import 'package:reel_t/events/user/google_sign_up/google_sign_up_event.dart';
import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';

import '../../../events/user/user_sign_in/user_sign_in_event.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_bloc.dart';
import 'login_screen.dart';

class LoginBloc extends AbstractBloc<LoginScreenState>
    with UserSignInEvent, SendEmailOtpEvent, GoogleSignUpEvent {
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
      sendSendEmailOtpEvent(email);
      this.signedInUserProfile = signedInUserProfile!;
      return;
    }
    state.showAlertDialog(
      title: "Login",
      content: e,
      confirm: () {
        state.popTopDisplay();
      },
    );
    print(e);
  }

  @override
  void onSendEmailOtpEventDone(bool isSent) {
    if (isSent) {
      state.stopLoading();
      state.pushToScreen(
          EmailAuthenticateScreen(email: signedInUserProfile.email));
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
      state.popTopDisplay();
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
}

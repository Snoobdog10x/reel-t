import 'package:reel_t/events/user/verify_user_email/verify_user_email_event.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';

import '../../../events/user/user_sign_in/user_sign_in_event.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_bloc.dart';
import 'login_screen.dart';

class LoginBloc extends AbstractBloc<LoginScreenState>
    with UserSignInEvent, VerifyUserEmailEvent {
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
      sendVerifyUserEmailEvent(email);
      this.signedInUserProfile = signedInUserProfile!;
      return;
    }
    state.showAlertDialog(title: "Login fail", content: e, confirm: () {});
    print(e);
  }

  @override
  void onVerifyUserEmailEventDone(e) {
    if (e.isEmpty) {
      state.stopLoading();
      state.pushToScreen(EmailAuthenticateScreen());
    }
    print(e);
  }
}

import 'package:reel_t/events/user/google_sign_up/google_sign_up_event.dart';
import 'package:reel_t/screens/user/signup/signup_screen.dart';

import '../../../events/user/user_sign_up/user_sign_up_event.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_bloc.dart';

class SignupBloc extends AbstractBloc<SignupScreenState>
    with UserSignUpEvent, GoogleSignUpEvent {
  String name = "";
  String email = "";
  String password = "";
  void signIn() {
    var hashedPassword = state.appStore.security.hashPassword(password);
    this.sendUserSignUpEvent(
      fullName: name,
      email: email,
      password: hashedPassword,
    );
  }

  @override
  void onUserSignUpEventDone(String errorMessage, UserProfile? signedUser) {
    state.stopLoading();
    if (errorMessage.isEmpty) {
      state.showAlertDialog(
        title: "Sign-up",
        content: "Success",
        confirm: () {
          appStore.localUser.login(signedUser!);
          state.popTopDisplay();
        },
      );
      return;
    }
    state.showAlertDialog(
      title: "Sign-up",
      content: errorMessage,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  @override
  void onGoogleSignUpEventDone(e, signedUser) {
    if (e.isEmpty) {
      return;
    }
    if (e == "success") {
      state.showAlertDialog(
        title: "Sign-up",
        content: "Success",
        confirm: () {
          appStore.localUser.login(signedUser!);
          state.popTopDisplay();
        },
      );
      return;
    }
    state.showAlertDialog(
      title: "Sign-up",
      content: e,
      confirm: () {
        // appStore.localUser.login(signedUser!);
        state.popTopDisplay();
      },
    );
  }
}

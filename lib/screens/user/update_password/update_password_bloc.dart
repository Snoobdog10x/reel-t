import 'package:reel_t/events/user/update_password/update_password_event.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';

import '../../../generated/abstract_bloc.dart';
import 'update_password_screen.dart';

class UpdatePasswordBloc extends AbstractBloc<UpdatePasswordScreenState>
    with UpdatePasswordEvent {
  String newPassword = "";
  String confirmPassword = "";
  bool isValidPassword = false;
  bool isMatchPassword() {
    if (newPassword.isEmpty) return false;
    return newPassword == confirmPassword;
  }

  void sendUpdatePassword() {
    if (isMatchPassword()) {
      var hashedPassword = appStore.security.hashPassword(newPassword);
      sendUpdatePasswordEvent(hashedPassword);
      return;
    }
    state.stopLoading();
    state.showAlertDialog(
      title: "Update Password",
      content: "Passwords not match",
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  @override
  void onUpdatePasswordEventDone(e) {
    if (e.isEmpty) {
      state.showAlertDialog(
        title: "Update Password",
        content:
            "Your password is updated, please login again with your new password",
        confirm: () async {
          await appStore.localUser.logout();
          await appStore.localUser.clearUser();
          await appStore.localSetting.clearSetting();
          state.popTopDisplay();
          state.pushToScreen(LoginScreen());
        },
      );
      return;
    }

    state.showAlertDialog(
      title: "Update Password",
      content: e,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }
}

import 'package:reel_t/events/user_sign_in/user_sign_in.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../generated/abstract_provider.dart';

class LoginProvider extends AbstractProvider with UserSignInEvent {
  String email = "";
  String password = "";
  void login() {
    var hashedPassword = appStore.security.hashPassword(password);
    sendUserSignInEvent(email, hashedPassword);
  }

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    if (e.isEmpty) {
      state.stopLoading();
      appStore.localUser.login(signedInUserProfile!);
      state.popTopDisplay();
      return;
    }
    state.showAlertDialog(title: "Login fail", content: e, confirm: () {});
    state.stopLoading();
  }
}

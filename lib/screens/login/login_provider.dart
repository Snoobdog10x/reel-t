import 'package:reel_t/events/user_sign_in/user_sign_in.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';

class LoginProvider extends AbstractProvider with UserSignInEvent {
  String email = "";
  String password = "";
  void login() {
    var hashedPassword = appStore.security.hashPassword(password);
    sendUserSignInEventEvent(email, hashedPassword);
  }

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    if (e.isEmpty) {
      state.stopLoading();
      appStore.localUser.login(signedInUserProfile!);
      return;
    }
    state.showAlertDialog(title: "Login fail", content: e, confirm: () {});
    state.stopLoading();
  }
}

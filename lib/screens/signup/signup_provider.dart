import 'package:reel_t/events/user_sign_up/user_sign_up.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';

class SignupProvider extends AbstractProvider with UserSignUpEvent {
  String name = "";
  String email = "";
  String password = "";
  late UserProfile userProfile;
  void signIn() {
    userProfile = UserProfile(
      fullName: name,
      email: email,
      numFollower: 0,
      numFollowing: 0,
    );
    var hashedPassword = state.appStore.security.hashPassword(password);
    this.sendUserSignUpEventEvent(userProfile, hashedPassword);
  }

  @override
  void onUserSignUpEventDone(String errorMessage) {
    state.stopLoading();
    if (errorMessage.isEmpty) {
      state.showAlertDialog(
        title: "Sign-up",
        content: "Success",
        confirm: () {
          state.popTopDisplay();
        },
      );
      state.appStore.localUser.login(userProfile);
      return;
    }
    state.showAlertDialog(
      title: "Sign-up",
      content: errorMessage,
      confirm: () {},
    );
  }
}

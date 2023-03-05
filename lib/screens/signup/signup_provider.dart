import 'package:reel_t/events/user_sign_in/user_sign_in.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';

class SignupProvider extends AbstractProvider with UserSignInEvent {
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
    this.sendUserSignInEventEvent(userProfile, password);
  }

  @override
  void onUserSignInEventDone(String errorMessage) {
    state.stopLoading();
    if (errorMessage.isEmpty) {
      state.showAlertDialog(
        title: "Sign-up",
        content: "Success",
        confirm: () {},
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

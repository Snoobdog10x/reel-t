import '../../../events/user/user_sign_in/user_sign_in_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'default_screen.dart';

class DefaultBloc extends AbstractBloc<DefaultScreenState>
    with UserSignInEvent {
  void init() {}

  @override
  void onUserSignInEventDone(String e, UserProfile? signedInUserProfile) {
    if (e.isEmpty) {
      appStore.localUser.logout();
      appStore.localUser.login(signedInUserProfile!);
    }
    print(e);
    state.stopLoading();
  }
}

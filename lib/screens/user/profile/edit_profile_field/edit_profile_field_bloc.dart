import '../../../../events/user/update_user_profile/update_user_profile_event.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../models/user_profile/user_profile.dart';
import 'edit_profile_field_screen.dart';

class EditProfileFieldBloc extends AbstractBloc<EditProfileFieldScreenState>
    with UpdateUserProfileEvent {
  late UserProfile currentUserProfile;
  void init() {
    currentUserProfile = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  void updateUserFullName(String newUserFullName) {
    currentUserProfile.fullName = newUserFullName;
    notifyDataChanged();
    sendUpdateUserProfileEvent(currentUserProfile);
    state.startLoading();
  }

  void updateUserName(String newUserName) {
    currentUserProfile.userName = newUserName;
    notifyDataChanged();
    sendUpdateUserProfileEvent(currentUserProfile);
    state.startLoading();
  }

  void updateBio(String newBio) {
    currentUserProfile.bio = newBio;
    notifyDataChanged();
    sendUpdateUserProfileEvent(currentUserProfile);
    state.startLoading();
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    state.stopLoading();
    state.popTopDisplay();
    // TODO: implement onUpdateUserProfileEventDone
    appStore.localUser.login(newUserProfile!);
  }
}

import '../../../../events/user/check_username_exists/check_username_exists_event.dart';
import '../../../../events/user/update_user_profile/update_user_profile_event.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../models/user_profile/user_profile.dart';
import 'edit_profile_field_screen.dart';

class EditProfileFieldBloc extends AbstractBloc<EditProfileFieldScreenState>
    with UpdateUserProfileEvent, CheckUsernameExistsEvent {
  late bool isUserNameExists = false;
  late UserProfile currentUserProfile;
  void init() {
    currentUserProfile = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  void updateUserFullName(String newUserFullName) {
    currentUserProfile.fullName = newUserFullName;
    notifyDataChanged();
    state.startLoading();
    sendUpdateUserProfileEvent(currentUserProfile);
  }

  void updateUserName(String newUserName) {
    currentUserProfile.userName = newUserName;
    notifyDataChanged();
    state.startLoading();
    sendUpdateUserProfileEvent(currentUserProfile);
  }

  void updateBio(String newBio) {
    currentUserProfile.bio = newBio;
    notifyDataChanged();
    state.startLoading();
    sendUpdateUserProfileEvent(currentUserProfile);
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    state.stopLoading();
    state.popTopDisplay();
    appStore.localUser.login(newUserProfile!);
  }

  @override
  void onCheckUsernameExistsEventDone(bool isExists) {
    isUserNameExists = isExists;
    // print(isUserNameExists);
    notifyDataChanged();
    // TODO: implement onCheckUsernameExistsEventDone
  }
}

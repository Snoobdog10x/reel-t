import '../../../../generated/abstract_bloc.dart';
import '../../../../models/user_profile/user_profile.dart';
import 'edit_profile_field_screen.dart';

class EditProfileFieldBloc extends AbstractBloc<EditProfileFieldScreenState> {
  void init() {
    currentUserProfile = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  late UserProfile currentUserProfile;
}

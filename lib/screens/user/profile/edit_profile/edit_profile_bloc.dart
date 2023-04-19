import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../../events/user/update_user_profile/update_user_profile_event.dart';
import '../../../../generated/abstract_bloc.dart';
import 'edit_profile_screen.dart';

class EditProfileBloc extends AbstractBloc<EditProfileScreenState>
    with UpdateUserProfileEvent {
  late UserProfile currentUser;
  Uint8List? avatar;

  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  void updateAvatar(String urlAvatar) {
    currentUser.avatar = urlAvatar;
    notifyDataChanged();
    sendUpdateUserProfileEvent(currentUser);
    state.startLoading();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    avatar = await image.readAsBytes();
    notifyDataChanged();
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    state.stopLoading();
    // TODO: implement onUpdateUserProfileEventDone
  }
}

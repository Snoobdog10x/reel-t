import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:reel_t/events/upload/upload_image/upload_image_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../../events/user/update_user_profile/update_user_profile_event.dart';
import '../../../../generated/abstract_bloc.dart';
import 'edit_profile_screen.dart';

class EditProfileBloc extends AbstractBloc<EditProfileScreenState>
    with UpdateUserProfileEvent, UploadImageEvent {
  late UserProfile currentUser;
  Uint8List? avatar;

  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  void updateAvatar(XFile image) {
    var fileName =
        "${currentUser.id}_${FormatUtility.getMillisecondsSinceEpoch()}.jpg";
    state.startLoading();
    sendUploadImageEvent(image, fileName);
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    avatar = await image.readAsBytes();
    notifyDataChanged();
    return image;
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    state.stopLoading();
    appStore.localUser.login(newUserProfile!);
  }

  @override
  void onUploadImageEventDone(String downloadUrl) {
    currentUser.avatar = downloadUrl;
    notifyDataChanged();
    sendUpdateUserProfileEvent(currentUser);
  }
}

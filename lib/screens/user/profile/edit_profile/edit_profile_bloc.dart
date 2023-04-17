import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../../generated/abstract_bloc.dart';
import 'edit_profile_screen.dart';

class EditProfileBloc extends AbstractBloc<EditProfileScreenState> {
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
  }

  late UserProfile currentUser;

  Uint8List? avatar;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    avatar = await image.readAsBytes();
    notifyDataChanged();
  }
}

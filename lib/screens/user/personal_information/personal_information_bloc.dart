import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reel_t/screens/user/personal_information/personal_information_screen.dart';

import '../../../generated/abstract_bloc.dart';

class PersonalInformationBloc
    extends AbstractBloc<PersonalInformationScreenState> {
  void init() {}
  Uint8List? avatar;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    avatar = await image.readAsBytes();
    notifyDataChanged();
  }

  String formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

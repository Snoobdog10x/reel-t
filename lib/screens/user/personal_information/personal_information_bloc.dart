import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reel_t/screens/user/personal_information/personal_information_screen.dart';

import '../../../generated/abstract_bloc.dart';

class PersonalInformationBloc
    extends AbstractBloc<PersonalInformationScreenState> {
  void init() {}

  XFile? avarta;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    avarta = await picker.pickImage(source: ImageSource.gallery);
    notifyDataChanged();
  }
  
  String formatDate(DateTime dateTime){
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

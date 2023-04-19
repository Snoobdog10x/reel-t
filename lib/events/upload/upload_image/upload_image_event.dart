import 'package:image_picker/image_picker.dart';

import '../../../generated/app_init.dart';
import '../../../generated/app_store.dart';

abstract class UploadImageEvent {
  final AppStore _appStore = AppInit.appStore;
  Future<void> sendUploadImageEvent(XFile imageFile, String fileName) async {
    try {
      var downloadUrl =
          await _appStore.cloudStorage.uploadFile(imageFile, fileName);
      onUploadImageEventDone(downloadUrl);
    } catch (e) {
      print(e);
      onUploadImageEventDone("");
    }
  }

  void onUploadImageEventDone(String downloadUrl);
}

import 'package:image_picker/image_picker.dart';
import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:reel_t/shared_product/utils/editor/video_editor.dart';
import 'package:video_compress/video_compress.dart';

import '../../../generated/app_init.dart';
import '../../../generated/app_store.dart';

abstract class UploadVideoEvent {
  final AppStore _appStore = AppInit.appStore;
  final VideoEditor _videoEditor = VideoEditor();
  Future<void> sendUploadVideoEvent(XFile videoFile, String fileName) async {
    try {
      await VideoCompress.setLogLevel(0);
      var compressedFile = await _videoEditor.compressFile(
        videoFile,
        isWeb: _appStore.isWeb(),
      );
      
      var downloadUrl = await _appStore.cloudStorage.uploadFile(
        compressedFile,
        fileName,
        type: File_Type.VIDEO,
      );

      onUploadVideoEventDone(downloadUrl);
    } catch (e) {
      print("UploadVideoEvent $e");
      onUploadVideoEventDone("");
    }
  }

  void onUploadVideoEventDone(String url);
}

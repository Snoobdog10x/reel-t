import 'package:image_picker/image_picker.dart';
import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:video_compress/video_compress.dart';

import '../../../generated/app_init.dart';
import '../../../generated/app_store.dart';

abstract class UploadVideoEvent {
  final AppStore _appStore = AppInit.appStore;
  Future<void> sendUploadVideoEvent(XFile videoFile, String fileName) async {
    try {
      await VideoCompress.setLogLevel(0);
      var compressedFile = await _compressFile(videoFile);
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

  Future<XFile> _compressFile(XFile video) async {
    if (_appStore.isWeb()) return video;
    final info = await VideoCompress.compressVideo(
      video.path,
      quality: VideoQuality.Res640x480Quality,
      deleteOrigin: false,
      includeAudio: true,
    );
    if (info == null) {
      return video;
    }
    return XFile(info.path!);
  }

  void onUploadVideoEventDone(String url);
}

import '../../../generated/abstract_bloc.dart';
import 'camera_ar_screen.dart';
import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraArBloc extends AbstractBloc<CameraArScreenState> {
  void init() {}
  Future<bool?> saveVideo(String path) async {
    return await GallerySaver.saveVideo(path);
  }

  Future<String> path(CaptureMode captureMode) async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String fileExtension =
        captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
    final String filePath =
        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
    return filePath;
  }
}

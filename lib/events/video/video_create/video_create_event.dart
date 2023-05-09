import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

abstract class VideoCreateEvent {
  Future<void> sendVideoCreateEvent(Video video) async {
    try {
      final db = FirebaseFirestore.instance.collection(Video.PATH);
      var doc = db.doc();
      video.id = doc.id;
      await doc.set(video.toJson());
      onVideoCreateEventDone(null);
    } catch (e) {
      onVideoCreateEventDone(e);
    }
  }

  void onVideoCreateEventDone(dynamic e);
}

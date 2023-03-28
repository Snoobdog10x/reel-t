import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/like/like.dart';

abstract class LikeVideoEvent {
  void sendLikeVideoEventEvent(Like like) {
    try {
      var db = FirebaseFirestore.instance
          .collection(Video.PATH)
          .doc(like.videoId)
          .collection(Like.PATH)
          .doc(like.id != "" ? like.id : null);
      var id = db.id;
      like.id = id;
      db.set(like.toJson());
      onLikeVideoEventDone(null);
    } catch (e) {
      onLikeVideoEventDone(e);
    }
  }

  void onLikeVideoEventDone(dynamic e);
}

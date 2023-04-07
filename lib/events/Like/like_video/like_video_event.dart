import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/like/like.dart';

abstract class LikeVideoEvent {
  Future<bool> sendLikeVideoEventEvent(Video video) async {
    try {
      var like = video.like.first;
      var db = FirebaseFirestore.instance
          .collection(Video.PATH)
          .doc(like.videoId)
          .collection(Like.PATH)
          .doc(like.id != "" ? like.id : null);
      var id = db.id;
      like.id = id;
      await db.set(like.toJson());
      onLikeVideoEventDone();
      return like.isLike;
    } catch (e) {
      onLikeVideoEventDone();
      return false;
    }
  }

  void onLikeVideoEventDone();
}

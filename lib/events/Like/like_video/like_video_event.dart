import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/video/video_detail.dart';

import '../../../models/like/like.dart';

abstract class LikeVideoEvent {
  void sendLikeVideoEventEvent(VideoDetail videoDetail) {
    try {
      var like = videoDetail.like!;
      var db = FirebaseFirestore.instance
          .collection(Video.PATH)
          .doc(like.videoId)
          .collection(Like.PATH)
          .doc(like.id != "" ? like.id : null);
      var id = db.id;
      like.id = id;
      db.set(like.toJson());
      onLikeVideoEventDone(null, videoDetail);
    } catch (e) {
      onLikeVideoEventDone(e, videoDetail);
    }
  }

  void onLikeVideoEventDone(dynamic e, VideoDetail videoDetail);
}

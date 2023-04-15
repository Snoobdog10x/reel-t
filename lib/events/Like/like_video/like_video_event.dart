import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../models/like/like.dart';

abstract class LikeVideoEvent {
  Future<void> sendLikeVideoEventEvent(
      String videoId, String currentUserId) async {
    try {
      var like = await _likeVideo(videoId, currentUserId);
      onLikeVideoEventDone(
        videoId: videoId,
        currentUserId: currentUserId,
        likeVideo: like,
      );
    } catch (e) {
      print(e);
      onLikeVideoEventDone(
        videoId: videoId,
        currentUserId: currentUserId,
        likeVideo: null,
      );
    }
  }

  Future<Like?> _getLikeVideo(String videoId, String currentUserId) async {
    final db = FirebaseFirestore.instance.collection(Video.PATH).doc(videoId);
    var snapshot = await db
        .collection(Like.PATH)
        .where(Like.userId_PATH, isEqualTo: currentUserId)
        .get();
    if (snapshot.docs.isEmpty) return null;

    return Like.fromJson(snapshot.docs.first.data());
  }

  Future<Like> _likeVideo(String videoId, String currentUserId) async {
    final db = FirebaseFirestore.instance
        .collection(Video.PATH)
        .doc(videoId)
        .collection(Like.PATH);
    var like = await _getLikeVideo(videoId, currentUserId);
    if (like != null) {
      like.isLike = !like.isLike;
      db.doc(like.id).set(like.toJson());
      return like;
    }

    var doc = db.doc();
    var newLike = Like(
      id: doc.id,
      userId: currentUserId,
      videoId: videoId,
      isLike: true,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    await doc.set(newLike.toJson());
    return newLike;
  }

  void onLikeVideoEventDone({
    String videoId = "",
    String currentUserId = "",
    Like? likeVideo,
  });
}

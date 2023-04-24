import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/comment/comment.dart';
import '../../../models/like/like.dart';
import '../../../models/video/video.dart';
import '../../../shared_product/utils/format/format_utlity.dart';

abstract class LikeCommentEvent {
  void sendLikeCommentEvent() {
    try {
      onLikeCommentEventDone(null);
    } catch (e) {
      onLikeCommentEventDone(e);
    }
  }

  // Future<Like?> _getLikeComment(Comment comment, String currentUserId) async {
  //   final db = FirebaseFirestore.instance.collection(Video.PATH).doc();
  //   var snapshot = await db
  //       .collection(Like.PATH)
  //       .where(Like.userId_PATH, isEqualTo: currentUserId)
  //       .get();
  //   if (snapshot.docs.isEmpty) return null;

  //   return Like.fromJson(snapshot.docs.first.data());
  // }

  // Future<Like> _likeVideo(String videoId, String currentUserId) async {
  //   final db = FirebaseFirestore.instance
  //       .collection(Video.PATH)
  //       .doc(videoId)
  //       .collection(Like.PATH);
  //   var like = await _getLikeVideo(videoId, currentUserId);
  //   if (like != null) {
  //     like.isLike = !like.isLike;
  //     db.doc(like.id).set(like.toJson());
  //     return like;
  //   }

  //   var doc = db.doc();
  //   var newLike = Like(
  //     id: doc.id,
  //     userId: currentUserId,
  //     videoId: videoId,
  //     isLike: true,
  //     createAt: FormatUtility.getMillisecondsSinceEpoch(),
  //   );
  //   await doc.set(newLike.toJson());
  //   return newLike;
  // }

  void onLikeCommentEventDone(dynamic e);
}

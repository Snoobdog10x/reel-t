import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/comment/comment.dart';

abstract class CreateCommentEvent {
  Future<void> sendCreateCommentEvent(Comment parentComment,
      {Comment? subComment}) async {
    try {
      await _createCommnet(parentComment, subComment);
      onCreateCommentEventDone(null);
    } catch (e) {
      print(e);
      onCreateCommentEventDone(e);
    }
  }

  void updateCommentNum() {}
  Future<void> _createCommnet(
      Comment? parentComment, Comment? subComment) async {
    if (parentComment == null) return;
    var db = FirebaseFirestore.instance
        .collection(Video.PATH)
        .doc(parentComment.videoId)
        .collection(Comment.PATH);
    DocumentReference<Map<String, dynamic>> parentRef;
    if (parentComment.id.isNotEmpty) {
      parentRef = db.doc(parentComment.id);
    } else {
      parentRef = db.doc();
      parentComment.id = parentRef.id;
    }

    await parentRef.set(parentComment.toJson());
    if (subComment == null) return;
    DocumentReference<Map<String, dynamic>> subRef;
    if (subComment.id.isNotEmpty) {
      subRef = parentRef.collection(Comment.PATH).doc(subComment.id);
      subComment.id = subRef.id;
    } else {
      subRef = parentRef.collection(Comment.PATH).doc();
    }

    subComment.parentCommentId = parentComment.id;
    await subRef.set(subComment.toJson());
  }

  void onCreateCommentEventDone(dynamic e);
}

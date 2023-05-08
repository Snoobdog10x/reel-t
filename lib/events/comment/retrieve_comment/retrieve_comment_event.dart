import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/comment/comment.dart';

import '../../../models/video/video.dart';

abstract class RetrieveCommentEvent {
  QueryDocumentSnapshot<Map<String, dynamic>>? _lastDocument;

  Future<void> sendRetrieveCommentEvent(String videoId) async {
    try {
      var parentComments = await _retrieveParentComment(videoId);
      onRetrieveCommentEventDone(parentComments);
    } catch (e) {
      print("RetrieveCommentEvent $e");
      onRetrieveCommentEventDone([]);
    }
  }

  Future<List<Comment>> _retrieveParentComment(String videoId) async {
    var db = FirebaseFirestore.instance
        .collection(Video.PATH)
        .doc(videoId)
        .collection(Comment.PATH);
    Query<Map<String, dynamic>> sortRef;
    if (_lastDocument != null)
      sortRef = db
          .orderBy(Comment.numLikes_PATH, descending: true)
          .startAfterDocument(_lastDocument!)
          .limit(7);
    else
      sortRef = db.orderBy(Comment.numLikes_PATH, descending: true).limit(7);
    var docs = (await sortRef.get()).docs;

    if (docs.isEmpty) return [];
    _lastDocument = docs.last;
    return docs.map((doc) => Comment.fromJson(doc.data())).toList();
  }

  void onRetrieveCommentEventDone(List<Comment> comments);
}

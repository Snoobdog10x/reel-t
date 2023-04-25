import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/comment/comment.dart';

abstract class StreamSubCommentEvent {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _streamSubcomment;
  void sendStreamSubCommentEvent(Comment parentComment) {
    try {
      final db = FirebaseFirestore.instance
          .collection(Video.PATH)
          .doc(parentComment.videoId)
          .collection(Comment.PATH);
      _streamSubcomment = db
          .orderBy(Comment.createAt_PATH, descending: true)
          .limit(4)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        List<Comment> newComments = [];
        docs.forEach((element) {
          if (element.type == DocumentChangeType.added) {
            if (element.doc.exists) {
              Comment newComment = Comment.fromJson(element.doc.data()!);
              Set<Comment> subcomments = Set.from(parentComment.subComments);
              subcomments.add(newComment);
              parentComment.subComments = subcomments.toList();
              newComments.add(newComment);
            }
          }
        });
        onStreamSubCommentEventDone(newComments);
      });
    } catch (e) {
      print(e);
      onStreamSubCommentEventDone([]);
    }
  }

  void disposeStreamSubCommentEvent() {
    _streamSubcomment?.cancel();
  }

  void onStreamSubCommentEventDone(List<Comment> newComments);
}

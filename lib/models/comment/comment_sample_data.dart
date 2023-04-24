import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/comment/comment.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../events/comment/create_comment/create_comment_event.dart';
import '../user_profile/user_profile.dart';

class CommentData with CreateCommentEvent {
  String mockAvatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  List<Comment> comments = [];

  void initCommentData() {
    List<String> contents = [
      "bạn xinh quá!",
      "wow trông thật cute",
      "hihi",
      "mãi keo"
    ];
    for (int j = 0; j < 52; j++) {
      for (int i = 0; i < 10; i++) {
        var id = i.toString();
        var comment = Comment(
          id: id,
          userId: id,
          videoId: j.toString(),
          content: contents[Random().nextInt(contents.length)],
          createAt: FormatUtility.getMillisecondsSinceEpoch(),
          numLikes: Random().nextInt(30000),
        );
        sendCreateCommentEvent(parentComment: comment);
        comments.add(comment);
      }
      comments[0].subComments.addAll(comments.getRange(0, 3));
      comments[2].subComments.addAll(comments.getRange(3, 6));
      comments[0].subComments.forEach((comment) {
        sendCreateCommentEvent(subComment: comment, parentComment: comments[0]);
      });
      comments[2].subComments.forEach((comment) {
        sendCreateCommentEvent(subComment: comment, parentComment: comments[2]);
      });
    }
  }

  @override
  void onCreateCommentEventDone(e) {
    // TODO: implement onCreateCommentEventDone
  }
}

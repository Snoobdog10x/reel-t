import 'dart:math';

import 'package:reel_t/events/comment/retrieve_comment/retrieve_comment_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/comment/comment.dart';
import 'comment_screen.dart';

class CommentBloc extends AbstractBloc<CommentScreenState>
    with RetrieveCommentEvent {
  String mockAvatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  List<Comment> comments = [];
  void init() {}

  @override
  void onRetrieveCommentEventDone(List<Comment> comments) {
    this.comments.addAll(comments);
    notifyDataChanged();
    // TODO: implement onRetrieveCommentEventDone
  }
}

import 'dart:math';

import 'package:reel_t/events/comment/retrieve_comment/retrieve_comment_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';

import '../../../events/comment/create_comment/create_comment_event.dart';
import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/comment/comment.dart';
import '../../../shared_product/utils/format/format_utlity.dart';
import 'comment_screen.dart';

class CommentBloc extends AbstractBloc<CommentScreenState>
    with RetrieveCommentEvent, RetrieveUserProfileEvent, CreateCommentEvent {
  Map<String, UserProfile> userCommentMap = {};
  late UserProfile curentUser;
  Comment? replyComment;
  List<Comment> comments = [];
  void init() {
    curentUser = appStore.localUser.getCurrentUser();
    userCommentMap[curentUser.id] = curentUser;
  }

  void sendComment(String comment) {
    if (!state.isLogin()) {
      state.pushToScreen(LoginScreen());
      return;
    }

    Comment newParentComment = Comment(
      userId: curentUser.id,
      videoId: state.widget.video.id,
      content: comment,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    comments.insert(0, newParentComment);
    sendCreateCommentEvent(newParentComment);
    notifyDataChanged();
  }

  void sendSubComment(String comment) {
    if (!state.isLogin()) {
      state.pushToScreen(LoginScreen());
      return;
    }
    if (replyComment == null) return;
    Comment newSubComment = Comment(
      userId: curentUser.id,
      videoId: state.widget.video.id,
      content: comment,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
      parentCommentId: replyComment!.id,
    );
    replyComment!.subCommentsNum++;
    sendCreateCommentEvent(replyComment!, subComment: newSubComment);

    replyComment = null;
    notifyDataChanged();
  }

  void sendLikes(Comment comment) {}

  void isCheckLikes() {}

  @override
  void onRetrieveCommentEventDone(List<Comment> comments) {
    comments.forEach((comment) {
      if (!userCommentMap.containsKey(comment.userId)) {
        sendRetrieveUserProfileEvent(userId: comment.userId);
      }
      if (!this.comments.contains(comment)) {
        this.comments.add(comment);
        comment.subComments.forEach((comment) {
          if (!userCommentMap.containsKey(comment.userId)) {
            sendRetrieveUserProfileEvent(userId: comment.userId);
          }
        });
      }
    });
    notifyDataChanged();
  }

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile == null) return;
    userCommentMap[userProfile.id] = userProfile;
    notifyDataChanged();
  }

  @override
  void onCreateCommentEventDone(e) {
    // TODO: implement onCreateCommentEventDone
  }
}

import 'dart:math';

import 'package:reel_t/events/comment/stream_sub_comment/stream_sub_comment_event.dart';

import '../../../../events/comment/create_comment/create_comment_event.dart';
import '../../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../../generated/abstract_bloc.dart';
import '../../../../models/comment/comment.dart';
import '../../../../models/user_profile/user_profile.dart';
import 'comment_block_screen.dart';

class CommentBlockBloc extends AbstractBloc<CommentBlockScreenState>
    with StreamSubCommentEvent, RetrieveUserProfileEvent {
  late Map<String, UserProfile> users;
  void init(Map<String, UserProfile> users) {
    this.users = users;
    notifyDataChanged();
  }

  UserProfile getUserProfile(Comment comment) {
    var userProfile = users[comment.userId];
    if (userProfile == null) return UserProfile();
    return userProfile;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeStreamSubCommentEvent();
  }

  @override
  void onStreamSubCommentEventDone(comments) {
    comments.forEach((element) {
      if (!users.containsKey(element.userId))
        sendRetrieveUserProfileEvent(userId: element.userId);
    });
    notifyDataChanged();
  }

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile == null) return;
    users[userProfile.id] = userProfile;
    notifyDataChanged();
  }
}

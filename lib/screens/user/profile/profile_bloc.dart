import 'package:reel_t/events/video/retrieve_user_video/retrieve_user_video_event.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';

import '../../../events/follow/follow_user/follow_user_event.dart';
import '../../../events/follow/get_follow_user/get_follow_user_event.dart';
import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ProfileBloc extends AbstractBloc<ProfileScreenState>
    with RetrieveUserVideoEvent, GetFollowUserEvent, FollowUserEvent {
  List<Video> userVideos = [];
  late UserProfile currentUser;
  late Follow userFollow;
  void init(Follow? userFollow) {
    this.userFollow = userFollow ?? Follow();
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    notifyDataChanged();
  }

  bool isFollowUser() {
    return userFollow.isFollow;
  }

  void sendUserFollow(String creatorId) {
    userFollow.isFollow = !userFollow.isFollow;
    notifyDataChanged();
    sendFollowUserEvent(creatorId, currentUser.id);
  }

  @override
  void onRetrieveUserVideoEventDone(List<Video> userVideos) {
    this.userVideos.addAll(userVideos);
    notifyDataChanged();
  }

  @override
  void onGetFollowUserEventDone({Follow? follow}) {
    userFollow = follow!;
    notifyDataChanged();
    // TODO: implement onGetFollowUserEventDone
  }

  @override
  void onFollowUserEventDone({String userId = "", Follow? follow}) {
    notifyDataChanged();
    // TODO: implement onFollowUserEventDone
  }
}

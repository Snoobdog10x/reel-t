import 'package:reel_t/events/video/retrieve_user_video/retrieve_user_video_event.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';
import 'package:reel_t/shared_product/vendors/collection/priority_set/priority_set.dart';

import '../../../events/follow/follow_user/follow_user_event.dart';
import '../../../events/follow/get_follow_user/get_follow_user_event.dart';
import '../../../events/user/streaming_user_profile/streaming_user_profile_event.dart';
import '../../../events/user/update_user_profile/update_user_profile_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ProfileBloc extends AbstractBloc<ProfileScreenState>
    with
        RetrieveUserVideoEvent,
        GetFollowUserEvent,
        FollowUserEvent,
        UpdateUserProfileEvent,
        StreamingUserProfileEvent {
  PrioritySet<Video> userVideos = new PrioritySet((p0, p1) {
    if (p0.createAt < p1.createAt) return 1;
    if (p0.createAt > p1.createAt) return -1;
    return 0;
  });

  late UserProfile currentUser;
  late Follow userFollow;
  bool lockFollow = false;
  void init(Follow? userFollow) {
    this.userFollow = userFollow ?? Follow();
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    notifyDataChanged();
  }

  bool isFollowUser() {
    return userFollow.isFollow;
  }

  void updateNumFollowUser(bool isFollowUser) {
    var user = state.widget.user;
    var currentUser = appStore.localUser.getCurrentUser();
    if (isFollowUser) {
      user.numFollower++;
      currentUser.numFollowing++;
      notifyDataChanged();
      sendUpdateUserProfileEvent(user);
      sendUpdateUserProfileEvent(currentUser);
      return;
    }

    user.numFollower--;
    currentUser.numFollowing--;
    notifyDataChanged();
    sendUpdateUserProfileEvent(user);
    sendUpdateUserProfileEvent(currentUser);
  }

  void sendUserFollow(String creatorId) {
    if (!appStore.localUser.isLogin()) {
      state.pushToScreen(LoginScreen());
      return;
    }
    if (lockFollow) return;

    userFollow.isFollow = !userFollow.isFollow;
    lockFollow = true;
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
    userFollow = follow ?? Follow(userId: state.widget.user.id);
    notifyDataChanged();
  }

  @override
  void onFollowUserEventDone({String userId = "", Follow? follow}) {
    userFollow = follow ?? Follow(userId: state.widget.user.id);
    updateNumFollowUser(isFollowUser());
    notifyDataChanged();
  }

  @override
  void dispose() {
    super.dispose();
    disposeStreamUserProfileEvent();
  }

  @override
  void onUpdateUserProfileEventDone(UserProfile? newUserProfile) {
    lockFollow = false;
    notifyDataChanged();
    // TODO: implement onUpdateUserProfileEventDone
  }

  @override
  void onStreamingUserProfileEventDone(UserProfile? currentUserProfile) {
    if (currentUserProfile != null) {
      state.widget.user.numFollowing = currentUserProfile.numFollowing;
      state.widget.user.numFollower = currentUserProfile.numFollower;
      state.widget.user.avatar = currentUserProfile.avatar;
      notifyDataChanged();
      if (currentUserProfile.id == this.currentUser.id) {
        appStore.localUser.login(currentUserProfile);
      }
    }
    // TODO: implement onStreamingUserProfileEventDone
  }
}

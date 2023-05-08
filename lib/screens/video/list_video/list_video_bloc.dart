import 'package:reel_t/events/Like/like_video/like_video_event.dart';
import 'package:reel_t/events/follow/follow_user/follow_user_event.dart';
import 'package:reel_t/events/video/retrieve_video_detail/retrieve_video_detail_event.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import '../../../events/follow/get_follow_user/get_follow_user_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import 'list_video_screen.dart';

class ListVideoBloc extends AbstractBloc<ListVideoScreenState>
    with
        RetrieveVideoDetailEvent,
        LikeVideoEvent,
        GetFollowUserEvent,
        FollowUserEvent {
  List<Video> sentRetrieveDetail = [];
  Map<String, UserProfile> creators = {};
  Map<String, Like?> likeVideos = {};
  Map<String, Follow?> followCreators = {};
  late UserProfile currentUser;
  String pushedUserId = "";
  int currentPage = 0;
  void init(List<Video> videos) {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
    videos.forEach((element) {
      loadVideoDetail(element);
    });
  }

  void loadVideoDetail(Video video) {
    if (sentRetrieveDetail.contains(video)) return;
    sentRetrieveDetail.add(video);
    sendRetrieveVideoDetailEvent(
      videoId: video.id,
      creatorId: video.creatorId,
      currentUserId: currentUser.id,
    );
  }

  bool isLoadVideoDetail(Video video) {
    if (creators[video.creatorId] == null) return false;

    return true;
  }

  bool isLikeVideo(Video video) {
    if (likeVideos[video.id] == null) return false;

    return likeVideos[video.id]!.isLike;
  }

  bool isFollowCreator(Video video) {
    if (followCreators[video.creatorId] == null) return false;

    return followCreators[video.creatorId]!.isFollow;
  }

  Future<void> likeVideo(Video video) async {
    if (!appStore.localUser.isLogin()) {
      state.pushToScreen(LoginScreen());
      return;
    }
    await sendLikeVideoEventEvent(video.id, currentUser.id);
  }

  @override
  void onRetrieveVideoDetailEventDone({
    String videoId = "",
    String creatorId = "",
    UserProfile? creator,
    Like? like,
    Follow? follow,
  }) {
    likeVideos[videoId] = like;
    followCreators[creatorId] = follow;
    if (creator != null) creators[creatorId] = creator;
    notifyDataChanged();
  }

  Future<void> followUser(Video video) async {
    if (!appStore.localUser.isLogin()) {
      state.pushToScreen(LoginScreen());
      return;
    }
    await sendFollowUserEvent(video.creatorId, currentUser.id);
  }

  @override
  void onLikeVideoEventDone(
      {String videoId = "", String currentUserId = "", Like? likeVideo}) {
    likeVideos[videoId] = likeVideo;
    notifyDataChanged();
  }

  @override
  void onFollowUserEventDone({String userId = "", Follow? follow}) {
    followCreators[userId] = follow;
    notifyDataChanged();
  }

  @override
  void onGetFollowUserEventDone({Follow? follow}) {
    followCreators[pushedUserId] = follow ?? Follow(userId: pushedUserId);
    notifyDataChanged();
  }
}

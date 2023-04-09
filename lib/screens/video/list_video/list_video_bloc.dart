import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:reel_t/events/Like/like_video/like_video_event.dart';
import 'package:reel_t/events/video/retrieve_video_detail/retrieve_video_detail_event.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import 'list_video_screen.dart';

class ListVideoBloc extends AbstractBloc<ListVideoScreenState>
    with RetrieveVideoDetailEvent, LikeVideoEvent {
  List<Video> videos = [];
  Map<Video, bool> _isLockSendDetail = {};
  late UserProfile currentUser;
  int currentPage = 0;
  void init(List<Video> videos) {
    currentUser = appStore.localUser.getCurrentUser();
    this.videos = videos;
    notifyDataChanged();
  }

  @override
  void onRetrieveVideoDetailEventDone(e) {
    if (e != null) {}
    notifyDataChanged();
  }

  void loadVideoDetail(Video video) {
    if (_isLockSendDetail[video] != null) return;
    _lockSendVideo(video);
    sendRetrieveVideoDetailEvent(
      currentUser: currentUser,
      video: video,
    );
  }

  bool isLoadVideoDetail(Video video) {
    if (video.creator.isEmpty) return false;
    // if (video.comment.isEmpty) return false;

    if (currentUser.id.isNotEmpty) {
      if (!isFollow(video)) return false;
      if (video.like.isEmpty) return false;
    }
    return true;
  }

  void _lockSendVideo(Video video) {
    if (_isLockSendDetail[video] != null) return;
    _isLockSendDetail[video] = true;
  }

  void _changeLikeState(Video video) {
    video.like.first.isLike = !video.like.first.isLike;
  }

  bool isFollow(Video video) {
    return video.followCreator.isNotEmpty;
  }

  Future<bool> likeVideo(Video video) async {
    if (!appStore.localUser.isLogin()) {
      state.pushToScreen(LoginScreen());
      return false;
    }
    _changeLikeState(video);
    bool isLike = await sendLikeVideoEventEvent(video);
    return isLike;
  }

  bool isLikeVideo(Video video) {
    return video.like.first.isLike;
  }

  @override
  void onLikeVideoEventDone() {
    // TODO: implement onLikeVideoEventDone
  }
}

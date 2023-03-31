import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:reel_t/events/Like/like_video/like_video_event.dart';
import 'package:reel_t/events/video/retrieve_video_detail/retrieve_video_detail_event.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/follow/follow.dart';
import '../../../generated/abstract_provider.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ListVideoProvider extends AbstractProvider
    with RetrieveVideoDetailEvent, LikeVideoEvent {
  List<Video> videos = [];
  Map<Video, bool> _isLockLike = {};
  Map<Follow, bool> _isLockFollow = {};
  Map<Video, bool> _isLockSendDetail = {};
  late UserProfile currentUser;
  int currentPage = 0;
  void init(List<Video> videos) {
    currentUser = appStore.localUser.getCurrentUser();
    this.videos = videos;
    notifyDataChanged();
  }

  String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  @override
  void onRetrieveVideoDetailEventDone(e) {
    if (e != null) {
      print(e);
    }
    notifyDataChanged();
  }

  void loadVideoDetail(Video video) {
    if (_isLockSendDetail[video] != null) return;
    _lockSendVideo(video);
    sendRetrieveVideoDetailEventEvent(
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

  void _lockLike(Video video) {
    if (_isLockLike[video] != null) return;
    _isLockLike[video] = true;
  }

  void _unlockLike(Video video) {
    if (_isLockLike[video] == null) return;
    _isLockLike.remove(video);
  }

  void _changeLikeState(Video video) {
    video.like.first.isLike = !video.like.first.isLike;
  }

  bool isFollow(Video video) {
    return video.followCreator.isNotEmpty;
  }

  void likeVideo(Video video) {
    if (_isLockLike[video] != null) return;
    _changeLikeState(video);
    _lockLike(video);
    sendLikeVideoEventEvent(video);
    notifyDataChanged();
  }

  bool isLikeVideo(Video video) {
    return video.like.first.isLike;
  }

  @override
  void onLikeVideoEventDone(e, Video video) {
    if (e == null) {
      _unlockLike(video);
      notifyDataChanged();
      return;
    }
    _unlockLike(video);
    _changeLikeState(video);
    notifyDataChanged();
  }
}

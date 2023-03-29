import 'package:intl/intl.dart';
import 'package:reel_t/events/Like/like_video/like_video_event.dart';
import 'package:reel_t/events/video/retrieve_video_detail/retrieve_video_detail_event.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/follow/follow.dart';
import '../../../generated/abstract_provider.dart';
import '../../../models/user_profile/user_profile.dart';
import '../video_detail.dart';

class ListVideoProvider extends AbstractProvider
    with RetrieveVideoDetailEvent, LikeVideoEvent {
  List<VideoDetail> videoDetails = [];
  late UserProfile currentUser;
  int currentPage = 0;
  void init(List<VideoDetail> videoDetails) {
    currentUser = appStore.localUser.getCurrentUser();
    this.videoDetails = videoDetails;
    notifyDataChanged();
  }

  String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  @override
  void onRetrieveVideoDetailEventDone(
    Like like,
    Follow follow,
    UserProfile creator,
    int index,
  ) {
    videoDetails[index].like = like;
    videoDetails[index].follow = follow;
    videoDetails[index].creator = creator;
    notifyDataChanged();
  }

  void likeVideo(VideoDetail videoDetail) {
    videoDetail.likeVideo();
    sendLikeVideoEventEvent(videoDetail);
    notifyDataChanged();
  }

  @override
  void onLikeVideoEventDone(e, VideoDetail videoDetail) {
    if (e == null) {
      videoDetail.unlockLike();
      return;
    }
    
    videoDetail.unlockLike();
    videoDetail.likeVideo();
    notifyDataChanged();
  }
}

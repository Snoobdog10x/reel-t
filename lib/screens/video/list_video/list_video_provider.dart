import 'package:intl/intl.dart';
import 'package:reel_t/events/follow/retrieve_follow_user/retrieve_follow_user_event.dart';
import 'package:reel_t/events/like/retrieve_like_video/retrieve_like_video_event.dart';
import '../../../generated/abstract_provider.dart';
import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ListVideoProvider extends AbstractProvider
    with RetrieveLikeVideoEvent, RetrieveFollowUserEvent {
  late UserProfile currentUser;
  final Map<String, UserProfile> creators = {};
  final Map<String, Follow> follows = {};
  final Map<String, Like> likes = {};
  int currentPage = 0;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
  }

  String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  void sendVideoDetailData(
    String videoId,
  ) {
    sendRetrieveLikeVideoEventEvent(videoId, currentUser.id);
  }

  bool isLoadDetail(String videoId) {
    if (creators[videoId] == null) {
      return false;
    }
    if (likes[videoId] == null) {
      return false;
    }
    if (follows[videoId] == null) {
      return false;
    }
    return true;
  }

  @override
  void onRetrieveLikeVideoEventDone(Like like) {
    likes[like.videoId] = like;
  }

  @override
  void onRetrieveFollowUserEventDone(Follow follow) {
    // follows[]
  }
}

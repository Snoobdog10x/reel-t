import 'dart:convert';

import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class VideoDetail {
  Video video;
  UserProfile? creator;
  Follow? follow;
  Like? like;
  VideoDetail({required this.video, this.creator, this.follow, this.like});
  @override
  String toString() {
    return "$video \n $creator \n $follow \n $like";
  }

  bool isLoadDetail() {
    if (creator == null) return false;
    if (follow == null) return false;
    if (like == null) return false;

    return true;
  }

  void likeVideo() {
    if (like == null) return;
    like!.likeVideo();
  }
}

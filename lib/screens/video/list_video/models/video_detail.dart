import 'dart:async';

import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/video/list_video/models/interfaces/media_interaction_interface.dart';

import '../../../../models/like/like.dart';

class VideoDetail with MediaInteractionInterface {
  late Video video;
  Like? like;
  VideoDetail(this.video);
  bool isLike() {
    if (like == null) return false;

    return like!.isLike;
  }

  @override
  void changeInteractionState() {
    if (like == null) {
      like = Like(videoId: video.id, isLike: true);
      return;
    }
    var isLike = like!.isLike;
    if (isLike) {
      video.likesNum--;
    } else {
      video.likesNum++;
    }
    
    like!.isLike = isLike;
  }

  void interactMedia(void Function() notifyDataChanged) {
    if (isLockInteractMedia()) return;
    changeInteractionState();
    lockInteractMedia();

    rollBackTimer = Timer(Duration(milliseconds: INTERACT_TIME_OUT), () {
      if (!isLockInteractMedia()) return;
      unlockInteractMedia();
      changeInteractionState();
      notifyDataChanged();
    });
  }
}

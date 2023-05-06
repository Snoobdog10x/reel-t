import 'dart:async';

import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/video/list_video/models/interfaces/media_interaction_interface.dart';

class CreatorDetail with MediaInteractionInterface {
  late UserProfile userProfile;
  Follow? follow;
  CreatorDetail(this.userProfile);
  bool isFollow() {
    if (follow == null) return false;
    
    return follow!.isFollow;
  }

  @override
  void changeInteractionState() {
    if (follow == null) {
      follow = Follow(userId: userProfile.id);
      return;
    }

    follow!.isFollow = !follow!.isFollow;
  }

  @override
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

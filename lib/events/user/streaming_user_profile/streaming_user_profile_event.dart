import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class StreamingUserProfileEvent {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _streamUserProfile;
  void sendStreamingUserProfileEvent(String currentUserId) {
    disposeStreamUserProfileEvent();
    try {
      final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
      _streamUserProfile = db.doc(currentUserId).snapshots().listen(
        (event) {
          if (event.exists)
            onStreamingUserProfileEventDone(
                UserProfile.fromJson(event.data()!));
        },
      );
    } catch (e) {
      onStreamingUserProfileEventDone(null);
    }
  }

  void disposeStreamUserProfileEvent() {
    _streamUserProfile?.cancel();
  }

  void onStreamingUserProfileEventDone(UserProfile? currentUserProfile);
}

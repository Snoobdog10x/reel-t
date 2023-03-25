import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveFollowUserEvent {
  Future<void> sendRetrieveFollowUserEventEvent(String currentUserId) async {
    try {
      var db = FirebaseFirestore.instance;
      var snapshot = await db
          .collection(UserProfile.PATH)
          .doc(currentUserId)
          .collection(Follow.PATH)
          .where("userId", isEqualTo: currentUserId)
          .get();
      onRetrieveFollowUserEventDone(null);
    } catch (e) {
      onRetrieveFollowUserEventDone(e);
    }
  }

  void onRetrieveFollowUserEventDone(dynamic e);
}


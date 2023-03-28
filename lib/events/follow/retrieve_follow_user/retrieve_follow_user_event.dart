import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveFollowUserEvent {
  Future<void> sendRetrieveFollowUserEventEvent(
    String currentUserId,
    String creatorId,
  ) async {
    try {
      var db = FirebaseFirestore.instance;
      var snapshot = await db
          .collection(Follow.PATH)
          .where("followerId", isEqualTo: currentUserId)
          .where("userId", isEqualTo: creatorId)
          .get();
      var docs = snapshot.docs;
      if (docs.isEmpty) {
        onRetrieveFollowUserEventDone(Follow());
        return;
      }
      var follow = Follow.fromJson(docs.first.data());
      onRetrieveFollowUserEventDone(follow);
    } catch (e) {
      onRetrieveFollowUserEventDone(Follow());
    }
  }

  void onRetrieveFollowUserEventDone(Follow follow);
}

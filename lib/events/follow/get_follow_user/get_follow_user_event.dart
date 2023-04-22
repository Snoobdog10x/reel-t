import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/follow/follow.dart';

abstract class GetFollowUserEvent {
  final _db = FirebaseFirestore.instance;

  Future<void> sendGetFollowUserEvent(
      String currentUserId, String creatorId) async {
    try {
      var follow = await _retrieveFollow(currentUserId, creatorId);
      onGetFollowUserEventDone(follow: follow);
    } catch (e) {
      print(e);
      onGetFollowUserEventDone();
    }
  }

  Future<Follow?> _retrieveFollow(
      String currentUserId, String creatorId) async {
    var snapshot = await _db
        .collection(Follow.PATH)
        .where(Follow.followerId_PATH, isEqualTo: currentUserId)
        .where(Follow.userId_PATH, isEqualTo: creatorId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) return null;
    return Follow.fromJson(docs.first.data());
  }

  void onGetFollowUserEventDone({Follow? follow});
}

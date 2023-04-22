import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/follow/follow.dart';

abstract class FollowUserEvent {
  Future<void> sendFollowUserEvent(String userId, String currentUserId) async {
    try {
      var follow = await _followUser(userId, currentUserId);
      onFollowUserEventDone(userId: userId, follow: follow);
    } catch (e) {
      print(e);
      onFollowUserEventDone(userId: userId, follow: null);
    }
  }

  Future<Follow?> _getFollowUser(String userId, String currentUserId) async {
    final db = FirebaseFirestore.instance.collection(Follow.PATH);
    var snapshot = await db
        .where(Follow.followerId_PATH, isEqualTo: currentUserId)
        .where(Follow.userId_PATH, isEqualTo: userId)
        .get();
    if (snapshot.docs.isEmpty) return null;

    return Follow.fromJson(snapshot.docs.first.data());
  }

  // void updateFollowUser() {}

  // void getFollowUserProfile() {
  //   final db;
  // }

  Future<Follow> _followUser(String userId, String currentUserId) async {
    final db = FirebaseFirestore.instance.collection(Follow.PATH);
    var follow = await _getFollowUser(userId, currentUserId);
    if (follow != null) {
      follow.isFollow = !follow.isFollow;
      await db.doc(follow.id).set(follow.toJson());
      return follow;
    }

    var doc = db.doc();
    var newFollow = Follow(
      id: doc.id,
      userId: userId,
      followerId: currentUserId,
      isFollow: true,
    );
    await doc.set(newFollow.toJson());
    return newFollow;
  }

  void onFollowUserEventDone({
    String userId = "",
    Follow? follow,
  });
}

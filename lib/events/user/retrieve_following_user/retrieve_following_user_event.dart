import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/follow/follow.dart';

abstract class RetrieveFollowingUserEvent {
  Future<void> sendRetrieveFollowingUserEvent(String userId) async {
    try {
      var followings = await _getUserFollowing(userId);
      var userProfiles = await _getUserProfile(followings);
      onRetrieveFollowingUserEventDone(userProfiles);
    } catch (e) {
      onRetrieveFollowingUserEventDone([]);
      print(e);
    }
  }

  Future<List<Follow>> _getUserFollowing(String userId) async {
    final db = FirebaseFirestore.instance.collection(Follow.PATH);
    var snapshot =
        await db.where(Follow.followerId_PATH, isEqualTo: userId).get();
    if (snapshot.docs.isEmpty) return [];
    return [for (var doc in snapshot.docs) Follow.fromJson(doc.data())];
  }

  Future<List<UserProfile>> _getUserProfile(List<Follow> followings) async {
    if (followings.isEmpty) return [];
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    List<Future<DocumentSnapshot<Map<String, dynamic>>>> awaitUser = [];
    for (var following in followings) {
      awaitUser.add(db.doc(following.userId).get());
    }
    var docs = await Future.wait(awaitUser);
    return [
      for (var doc in docs)
        if (doc.exists) UserProfile.fromJson(doc.data()!)
    ];
  }

  void onRetrieveFollowingUserEventDone(List<UserProfile> userProfiles);
}

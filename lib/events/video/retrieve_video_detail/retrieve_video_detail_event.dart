import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/video/video_detail.dart';

import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/video/video.dart';

abstract class RetrieveVideoDetailEvent {
  var db = FirebaseFirestore.instance;
  Future<void> sendRetrieveVideoDetailEventEvent({
    required String videoId,
    required String currentUserId,
    required String creatorId,
    required int index,
  }) async {
    try {
      Follow follow = await _retrieveFollow(currentUserId, creatorId);
      Like like = await _retrieveLike(videoId, currentUserId);
      UserProfile creator = await _retrieveCreator(creatorId);
      onRetrieveVideoDetailEventDone(like, follow, creator, index);
    } catch (e) {
      // onRetrieveVideoDetailEventDone(e);
      print(e);
    }
  }

  Future<UserProfile> _retrieveCreator(String creatorId) async {
    try {
      var snapshot = await db.collection(UserProfile.PATH).doc(creatorId).get();
      var data = snapshot.data();
      return UserProfile.fromJson(data ?? {});
    } catch (e) {
      return UserProfile();
    }
  }

  Future<Follow> _retrieveFollow(String currentUserId, String creatorId) async {
    var snapshot = await db
        .collection(Follow.PATH)
        .where("followerId", isEqualTo: currentUserId)
        .where("userId", isEqualTo: creatorId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) {
      return Follow();
    }
    return Follow.fromJson(docs.first.data());
  }

  Future<Like> _retrieveLike(String videoId, String currentUserId) async {
    var snapshot = await db
        .collection(Video.PATH)
        .doc(videoId)
        .collection(Like.PATH)
        .where("userId", isEqualTo: currentUserId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) {
      return Like(videoId: videoId, userId: currentUserId);
    }
    return Like.fromJson(docs.first.data());
  }

  void onRetrieveVideoDetailEventDone(
    Like like,
    Follow follow,
    UserProfile creator,
    int index,
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/video/video.dart';

abstract class RetrieveVideoDetailEvent {
  final _db = FirebaseFirestore.instance;
  List<Future> _awaitVideoDetails = [];
  Future<void> sendRetrieveVideoDetailEvent({
    required String videoId,
    required String creatorId,
    required String currentUserId,
  }) async {
    try {
      var creator = await _retrieveCreator(creatorId);
      var follow = await _retrieveFollow(currentUserId, creatorId);
      var like = await _retrieveLike(videoId, currentUserId);
      onRetrieveVideoDetailEventDone(
        videoId: videoId,
        creatorId: creatorId,
        creator: creator,
        follow: follow,
        like: like,
      );
    } catch (e) {
      print(e);
      onRetrieveVideoDetailEventDone();
    }
  }

  Future<UserProfile> _retrieveCreator(String creatorId) async {
    var snapshot = await _db.collection(UserProfile.PATH).doc(creatorId).get();
    var data = snapshot.data();
    return UserProfile.fromJson(data ?? {});
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

  Future<Like?> _retrieveLike(String videoId, String currentUserId) async {
    var snapshot = await _db
        .collection(Video.PATH)
        .doc(videoId)
        .collection(Like.PATH)
        .where("userId", isEqualTo: currentUserId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) return null;

    return Like.fromJson(docs.first.data());
  }

  void onRetrieveVideoDetailEventDone({
    String videoId,
    String creatorId,
    UserProfile? creator,
    Like? like,
    Follow? follow,
  });
}

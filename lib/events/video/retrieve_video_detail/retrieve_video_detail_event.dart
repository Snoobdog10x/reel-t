import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/video/video.dart';

abstract class RetrieveVideoDetailEvent {
  var _db = FirebaseFirestore.instance;
  List<Future> _awaitVideoDetails = [];
  Future<void> sendRetrieveVideoDetailEvent({
    required String videoId,
    required String creatorId,
    required String currentUserId,
  }) async {
    try {
      _awaitVideoDetails.add(_retrieveCreator(creatorId));
      _awaitVideoDetails.add(_retrieveFollow(currentUserId, creatorId));
      _awaitVideoDetails.add(_retrieveLike(videoId, currentUserId));
      List detailData = await Future.wait(_awaitVideoDetails);
      var creator = detailData[0] as UserProfile;
      var follow = detailData[1] as Follow?;
      var like = detailData[2] as Like?;

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
        .where("followerId", isEqualTo: currentUserId)
        .where("userId", isEqualTo: creatorId)
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

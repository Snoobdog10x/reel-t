import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/video/video.dart';

abstract class RetrieveVideoDetailEvent {
  var db = FirebaseFirestore.instance;
  Future<void> sendRetrieveVideoDetailEventEvent({
    UserProfile? currentUser,
    required Video video,
  }) async {
    try {
      if (currentUser != null) {
        Follow follow = await _retrieveFollow(currentUser.id, video.creatorId);
        Like like = await _retrieveLike(video.id, currentUser.id);
        video.followCreator.add(follow);
        video.like.add(like);
      }

      UserProfile creator = await _retrieveCreator(video.creatorId);
      video.creator.add(creator);
      onRetrieveVideoDetailEventDone(null);
    } catch (e) {
      onRetrieveVideoDetailEventDone(e);
    }
  }

  Future<UserProfile> _retrieveCreator(String creatorId) async {
    try {
      var snapshot = await db.collection(UserProfile().PATH).doc(creatorId).get();
      var data = snapshot.data();
      return UserProfile.fromJson(data ?? {});
    } catch (e) {
      return UserProfile();
    }
  }

  Future<Follow> _retrieveFollow(String currentUserId, String creatorId) async {
    var snapshot = await db
        .collection(Follow().PATH)
        .where("followerId", isEqualTo: currentUserId)
        .where("userId", isEqualTo: creatorId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) {
      return Follow(followerId: currentUserId, userId: creatorId);
    }
    return Follow.fromJson(docs.first.data());
  }

  Future<Like> _retrieveLike(String videoId, String currentUserId) async {
    var snapshot = await db
        .collection(Video().PATH)
        .doc(videoId)
        .collection(Like().PATH)
        .where("userId", isEqualTo: currentUserId)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) {
      return Like(videoId: videoId, userId: currentUserId);
    }
    return Like.fromJson(docs.first.data());
  }

  void onRetrieveVideoDetailEventDone(e);
}

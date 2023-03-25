import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/video/video.dart';

abstract class RetrieveLikeVideoEvent {
  Future<void> sendRetrieveLikeVideoEventEvent(
      String videoId, String currentUserId) async {
    try {
      var db = FirebaseFirestore.instance;
      var snapshot = await db
          .collection(Video.PATH)
          .doc(videoId)
          .collection(Like.PATH)
          .where("userId", isEqualTo: currentUserId)
          .get();

      var docs = snapshot.docs;
      if (docs.isEmpty) {
        onRetrieveLikeVideoEventDone(null, videoId);
        return;
      }
      onRetrieveLikeVideoEventDone(Like.fromJson(docs.first.data()), videoId);
    } catch (e) {
      print(e);
      onRetrieveLikeVideoEventDone(null, videoId);
    }
  }

  void onRetrieveLikeVideoEventDone(Like? like, String videoId);
}

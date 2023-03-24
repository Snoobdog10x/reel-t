import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/video/video.dart';

abstract class RetrieveVideosEvent {
  void sendRetrieveVideosEvent(int page, int limit) async {
    try {
      final db = FirebaseFirestore.instance;
      var snapshot = await db
          .collection("Videos")
          .limit(limit)
          .get();
      List<Video> videos = [];
      for (var doc in snapshot.docs) {
        videos.add(Video.fromJson(doc.data()));
      }
      onRetrieveVideosEventDone(null, videos);
    } catch (e) {
      onRetrieveVideosEventDone(e, []);
    }
  }

  void onRetrieveVideosEventDone(dynamic e, List<Video> loadedVideo);
}

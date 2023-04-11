import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

abstract class RetrieveUserVideoEvent {
  late var lastDocument;
  Future<void> sendRetrieveUserVideoEvent(String userId) async {
    try {
      print(userId);
      var userVideos = await _retrieveUserVideos(userId);
      onRetrieveUserVideoEventDone(userVideos);
    } catch (e) {
      onRetrieveUserVideoEventDone([]);
    }
  }

  Future<List<Video>> _retrieveUserVideos(String userId) async {
    var snapShot = await _getSnapShot(userId);
    var docs = snapShot.docs;
    print(snapShot.docs);
    if (docs.isEmpty) {
      return [];
    }
    lastDocument = snapShot.docs.first;
    return [for (var doc in docs) Video.fromJson(doc.data())];
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getSnapShot(
      String userId) async {
    final db = FirebaseFirestore.instance.collection(Video.PATH);
    if (lastDocument == null) {
      return await db
          .orderBy(Video.createAt_PATH, descending: true)
          .where(Video.creatorId_PATH, isEqualTo: userId)
          .limit(10)
          .get();
    }

    return await db
        .orderBy(Video.createAt_PATH, descending: true)
        .where(Video.creatorId_PATH, isEqualTo: userId)
        .startAfterDocument(lastDocument)
        .limit(10)
        .get();
  }

  void onRetrieveUserVideoEventDone(List<Video> userVideos);
}

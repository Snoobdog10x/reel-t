import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

abstract class RetrieveUserVideoEvent {
  var _lastDocument;
  int _LIMIT_VIDEO = 9;
  Future<void> sendRetrieveUserVideoEvent(String userId) async {
    try {
      var userVideos = await _retrieveUserVideos(userId);
      onRetrieveUserVideoEventDone(userVideos);
    } catch (e) {
      print(e);
      onRetrieveUserVideoEventDone([]);
    }
  }

  Future<List<Video>> _retrieveUserVideos(String userId) async {
    var snapShot = await _getSnapShot(userId);
    var docs = snapShot.docs;
    if (docs.isEmpty) {
      return [];
    }

    _lastDocument = snapShot.docs.first;
    return [for (var doc in docs) Video.fromJson(doc.data())];
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getSnapShot(
      String userId) async {
    final db = FirebaseFirestore.instance.collection(Video.PATH);
    if (_lastDocument == null) {
      return await db
          .where(Video.creatorId_PATH, isEqualTo: userId)
          .orderBy(Video.createAt_PATH, descending: true)
          .limit(_LIMIT_VIDEO)
          .get();
    }

    return await db
        .where(Video.creatorId_PATH, isEqualTo: userId)
        .orderBy(Video.createAt_PATH, descending: true)
        .startAfterDocument(_lastDocument)
        .limit(_LIMIT_VIDEO)
        .get();
  }

  void onRetrieveUserVideoEventDone(List<Video> userVideos);
}

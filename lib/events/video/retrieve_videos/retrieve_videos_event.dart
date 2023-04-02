import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/video/video.dart';

abstract class RetrieveVideosEvent {
  final _db = FirebaseFirestore.instance.collection(Video.PATH);
  DocumentSnapshot? _lastRecord;
  void sendRetrieveVideosEvent(int limit) async {
    try {
      var snapshot = await _buildSnapshot(limit);
      List<Video> videos = [
        for (var doc in snapshot.docs) Video.fromJson(doc.data())
      ];
      onRetrieveVideosEventDone(null, videos);
    } catch (e) {
      onRetrieveVideosEventDone(e, []);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _buildSnapshot(int limit) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (_lastRecord == null) {
      snapshot = await _db.limit(limit).get();
    } else {
      snapshot = await _db.startAfterDocument(_lastRecord!).limit(limit).get();
    }

    _lastRecord = snapshot.docs.last;
    return snapshot;
  }

  void onRetrieveVideosEventDone(dynamic e, List<Video> loadedVideo);
}

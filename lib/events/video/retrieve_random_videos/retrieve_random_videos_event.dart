import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../models/video/video.dart';

abstract class RetrieveRandomVideosEvent {
  Future<void> sendRetrieveRandomVideosEvent(int limit) async {
    try {
      var videos = await _getRandomVideos(limit);
      onRetrieveRandomVideosEventDone(videos);
    } catch (e) {
      print("RetrieveRandomVideosEvent $e");
      onRetrieveRandomVideosEventDone([]);
    }
  }

  Future<List<Video>> _getRandomVideos(int limit) async {
    List<Future<Video>> videos = [];
    for (int i = 0; i < limit; i++) {
      videos.add(_getRandomVideo());
    }
    return await Future.wait(videos);
  }

  Future<Video> _getRandomVideo() async {
    final db = FirebaseFirestore.instance.collection(Video.PATH);
    final randomId = db.doc().id;
    var random = Random();
    var snapshot = await db
        .where(Video.id_PATH, isGreaterThanOrEqualTo: randomId)
        .orderBy('id')
        .limit(10)
        .get();
    if (snapshot.docs.isNotEmpty)
      return Video.fromJson(
          snapshot.docs[random.nextInt(snapshot.docs.length)].data());

    snapshot = await db
        .where(Video.id_PATH, isLessThan: randomId)
        .orderBy('id', descending: true)
        .limit(10)
        .get();
    return Video.fromJson(
        snapshot.docs[random.nextInt(snapshot.docs.length)].data());
  }

  void onRetrieveRandomVideosEventDone(List<Video> randomVideos);
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/video/video.dart';

import '../../shared_product/services/cloud_storage.dart';
import '../like/like.dart';

class VideoData {
  CloudStorage cloudStorage = CloudStorage();
  Future<List<Video>> getVideoData() async {
    var videoUrls = await cloudStorage.getDownloadURLs();
    List<Video> videoData = [];
    final _random = new Random();
    for (int i = 0; i < videoUrls.length; i++) {
      videoData.add(
        Video(
          id: i.toString(),
          videoUrl: videoUrls[_random.nextInt(videoUrls.length)],
          songName: "",
          creatorId: "",
          publicMode: PublicMode.PUBLIC.index,
          likesNum: _random.nextInt(2000000),
          comments: _random.nextInt(2000000),
          viewsNum: _random.nextInt(2000000),
          isDeleted: false,
        ),
      );
    }
    return videoData;
  }

  Future<void> initSampleData() async {
    var videos = await getVideoData();
    for (var video in videos) {
      final db = FirebaseFirestore.instance;
      db
          .collection("Videos")
          .doc(videos.indexOf(video).toString())
          .set(video.toJson());
    }
  }
}

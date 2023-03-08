import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/models/video/video_data.dart';
import 'package:reel_t/shared_product/services/app_store.dart';

class FirstInit {
  static final AppStore appStore = AppStore();

  void addVideos() {
    final db = FirebaseFirestore.instance;
    VideoData videoData = VideoData();
    videoData.getVideoData().forEach((video) async {
      await db.collection("Videos").doc(video.id).set(video.toJson());
    });
  }
}


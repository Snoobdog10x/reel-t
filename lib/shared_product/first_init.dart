import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/models/video/video_data.dart';
import 'package:reel_t/shared_product/services/app_store.dart';

class FirstInit {
  final AppStore appStore = AppStore();

  Future<void> init() async {
    await appStore.init();
    // addVideos();
  }

  void addVideos() {
    final db = FirebaseFirestore.instance;
    VideoData videoData = VideoData();
    videoData.getVideoData().forEach((video) async {
      await db.collection("Videos").doc(video.id).set(video.toJson());
      print("hihi");
    });
  }
}

class SetUp {
  static FirstInit firstInit = FirstInit();
}

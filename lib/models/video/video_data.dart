import 'dart:math';

import 'package:reel_t/models/video/video.dart';

import '../like/like.dart';

class VideoData {
  List<Video> getVideoData() {
    List<Video> videoData = [];
    List<String> videoUrls = [
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_1.mp4?alt=media&token=881730bb-a631-4d37-ae55-dc519fcd7f27",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_10.mp4?alt=media&token=1180ce57-2bc8-4e39-ad0f-2a87b421e8e8",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_11.mp4?alt=media&token=d89737a5-202a-4990-af51-d679dcc39c3f",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_12.mp4?alt=media&token=9a0da858-7549-4bba-b8ef-769c6545c06a",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_13.mp4?alt=media&token=6dddc387-bb78-465f-b1c4-49cde1440e97",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_14.mp4?alt=media&token=adf3fb22-c79d-481b-a8d0-a36c5a446e4f",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_2.mp4?alt=media&token=f4742f0c-d5f5-4a1a-9157-1182f6e11413",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_3.mp4?alt=media&token=13a48cda-9bb5-4637-94de-5f08ac0a7a2d",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_4.mp4?alt=media&token=ec389ba0-da76-4cba-92c7-589c1e21d1fc",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_5.mp4?alt=media&token=edfbbae5-f97e-46c3-bffe-a1938db2a74b",
      "https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_6.mp4?alt=media&token=57f64899-2b2a-4a1f-be24-3e6648a3d484",
    ];
    final _random = new Random();
    for (int i = 0; i < 60; i++) {
      videoData.add(
        Video(
          id: i.toString(),
          videoUrl: videoUrls[_random.nextInt(videoUrls.length)],
          songName: "",
          creatorId: "",
          publicMode: PublicMode.PUBLIC.index,
          likes: _random.nextInt(2000000),
          comments: _random.nextInt(2000000),
          views: _random.nextInt(2000000),
          isDeleted: false,
        ),
      );
    }
    return videoData;
  }
}

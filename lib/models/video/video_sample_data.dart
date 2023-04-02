import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/video/video.dart';

class VideoData {
  List<Video> _getVideoData() {
    var videoUrls = [
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_1.mp4?alt=media&token=b0ae926e-5e2b-4d3f-85f1-ea8ee9263293",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_10.mp4?alt=media&token=f795a2f3-47bc-45a8-bcd1-1aa11cd7ae12",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_11.mp4?alt=media&token=bc64740d-8d30-4ecf-b484-763792411755",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_12.mp4?alt=media&token=6972d501-1497-4ccc-a5ee-4463f49cf38e",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_13.mp4?alt=media&token=5cd9438f-6785-4896-ac7b-14a378a3dc2e",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_14.mp4?alt=media&token=77ad53b0-936e-4e79-9057-580392d5510c",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_2.mp4?alt=media&token=0324266d-b7f9-470e-9b29-d92e13bb7de2",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_3.mp4?alt=media&token=aee80554-e1dd-43ed-80d4-c41ede47c47e",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_4.mp4?alt=media&token=1bf1c326-1aa8-40a6-9390-51624d758d97",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_5.mp4?alt=media&token=6bceaffb-6366-4555-9081-3ef199fac507",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_6.mp4?alt=media&token=1b2fa903-a69b-4dd8-88ca-d7c950afd3be",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_7.mp4?alt=media&token=ae252736-45fa-40c8-bd43-8511d80e5095",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_8.mp4?alt=media&token=72d18ac1-7a29-4b90-bdcd-5d0ee7e648fc",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Beauty_9.mp4?alt=media&token=0bbb7d0a-d1b1-4010-ba31-6effb2a30000",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_1.mp4?alt=media&token=5fad6cd4-b21d-4761-9d3b-a89a13624a9c",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_10.mp4?alt=media&token=4a742646-25ed-43af-8ce7-bdef62b7fc2a",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_2.mp4?alt=media&token=8c1dbdc2-226b-4222-a9e4-2a3c73f8d169",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_3.mp4?alt=media&token=4f182b3c-06d1-492b-beaf-6ff71f2b0143",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_4.mp4?alt=media&token=61617518-c7a3-419d-b252-6e13175654ef",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_5.mp4?alt=media&token=bbd7d937-3fdb-467b-9d8d-0c1b50806a95",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_6.mp4?alt=media&token=688a5fb4-646c-4d11-9375-98be8748a866",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_7.mp4?alt=media&token=b3f34cf3-14db-4570-bd1f-2d555e28c19b",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_8.mp4?alt=media&token=691f1735-bf5b-441b-bb99-52d7e8f780ab",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Dance_9.mp4?alt=media&token=6bca032c-289e-4fd7-8ad9-6d4993332bdb",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Entertainment_1.mp4?alt=media&token=27a0ba9b-39f4-483c-ae23-b98b50889ccd",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/videos%2F02062023_video_Entertainment_10.mp4?alt=media&token=8798186b-a978-4305-b8bf-2773a61786c1",
    ];
    List<Video> videoData = [];
    final _random = new Random();
    for (int i = 0; i < videoUrls.length; i++) {
      var url = videoUrls[i];
      videoData.add(
        Video(
          id: i.toString(),
          videoUrl: url,
          songName: "",
          creatorId: "${_random.nextInt(10)}",
          publicMode: PublicMode.PUBLIC.index,
          likesNum: _random.nextInt(2000000),
          commentsNum: _random.nextInt(2000000),
          title: "xinh ghê nè <3",
          viewsNum: _random.nextInt(2000000),
          isDeleted: false,
          createAt: Timestamp.now().millisecondsSinceEpoch,
        ),
      );
    }
    return videoData;
  }

  Future<void> initVideoData() async {
    var videos = await _getVideoData();
    for (var video in videos) {
      final db = FirebaseFirestore.instance;
      db
          .collection(Video.PATH)
          .doc(videos.indexOf(video).toString())
          .set(video.toJson());
    }
  }
}

import 'package:reel_t/screens/video/video_detail.dart';

import '../../../events/video/retrieve_videos/retrieve_videos_event.dart';
import '../../../generated/abstract_provider.dart';
import '../../../models/video/video.dart';

class FeedProvider extends AbstractProvider with RetrieveVideosEvent {
  List<VideoDetail> forYou = [];
  List<VideoDetail> following = [];
  int page = 0;
  int limit = 5;
  void sendRetrieveVideos() {
    this.sendRetrieveVideosEvent(page, limit);
  }

  @override
  void onRetrieveVideosEventDone(e, List<Video> loadedVideo) {
    if (e == null) {
      page++;
      for (var video in loadedVideo) {
        forYou.add(VideoDetail(video: video));
      }

      notifyDataChanged();
      return;
    }
    print(e);
  }
}

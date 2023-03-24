import 'package:reel_t/events/retrieve_videos/retrieve_videos.dart';

import '../../../generated/abstract_provider.dart';
import '../../../models/video/video.dart';

class FeedProvider extends AbstractProvider with RetrieveVideosEvent {
  List<Video> forYou = [];
  List<Video> following = [];
  int page = 0;
  int limit = 5;
  void sendRetrieveVideos() {
    this.sendRetrieveVideosEvent(page, limit);
  }

  @override
  void onRetrieveVideosEventDone(e, List<Video> loadedVideo) {
    if (e == null) {
      page++;
      forYou.addAll(loadedVideo);
      notifyDataChanged();
      return;
    }
    print(e);
  }
}

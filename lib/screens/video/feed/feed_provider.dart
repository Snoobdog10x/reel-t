import '../../../events/video/retrieve_videos/retrieve_videos_event.dart';
import '../../../generated/abstract_provider.dart';
import '../../../models/video/video.dart';

class FeedProvider extends AbstractProvider with RetrieveVideosEvent {
  List<Video> forYou = [];
  List<Video> following = [];
  int limit = 5;
  void sendRetrieveVideos() {
    this.sendRetrieveVideosEvent(limit);
  }

  @override
  void onRetrieveVideosEventDone(e, List<Video> loadedVideo) {
    if (e == null) {
      forYou.addAll(loadedVideo);
      notifyDataChanged();
      print([for (var video in forYou) video.id]);
      return;
    }
    print(e);
  }
}

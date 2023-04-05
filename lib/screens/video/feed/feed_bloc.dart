import '../../../events/video/retrieve_videos/retrieve_videos_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/video/video.dart';

class FeedBloc extends AbstractBloc with RetrieveVideosEvent {
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
      return;
    }
  }
}

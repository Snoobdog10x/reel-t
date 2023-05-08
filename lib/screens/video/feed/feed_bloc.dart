import 'package:reel_t/events/video/retrieve_random_videos/retrieve_random_videos_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/video/video.dart';
import 'feed_screen.dart';

class FeedBloc extends AbstractBloc<FeedScreenState>
    with RetrieveRandomVideosEvent {
  List<Video> forYou = [];
  List<Video> following = [];
  int limit = 5;
  void sendRetrieveVideos() {
    sendRetrieveRandomVideosEvent(limit);
  }

  @override
  void onRetrieveRandomVideosEventDone(List<Video> randomVideos) {
    forYou.addAll(randomVideos);
    forYou = forYou.toSet().toList();
    notifyDataChanged();
    return;
  }
}

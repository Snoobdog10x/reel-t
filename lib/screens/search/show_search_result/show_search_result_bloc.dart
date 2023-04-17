import '../../../events/user/search_user/search_user_event.dart';
import '../../../events/video/search_video/search_video_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import 'show_search_result_screen.dart';

class ShowSearchResultBloc extends AbstractBloc<ShowSearchResultScreenState>
    with SearchUserEvent, SearchVideoEvent {
  List<UserProfile> searchUserResult = [];
  List<Video> searchVideoResult = [];
  @override
  void onSearchVideoEventDone(List<Video> videos) {
    searchVideoResult = videos;
    notifyDataChanged();
  }

  @override
  void onSearchUserEventDone(List<UserProfile> userProfiles) {
    searchUserResult = userProfiles;
    notifyDataChanged();
  }
}

import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';

import '../../../events/user/search_user/search_user_event.dart';
import '../../../events/video/search_video/search_video_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import 'show_search_result_screen.dart';

class ShowSearchResultBloc extends AbstractBloc<ShowSearchResultScreenState>
    with SearchUserEvent, SearchVideoEvent, RetrieveUserProfileEvent {
  List<UserProfile> searchUserResult = [];
  List<Video> searchVideoResult = [];
  Map<String, UserProfile> users = {};
  @override
  void onSearchVideoEventDone(List<Video> videos) {
    searchVideoResult = videos;
    videos.forEach(
      (video) {
        if (!users.containsKey(video.creatorId)) {
          sendRetrieveUserProfileEvent(userId: video.creatorId);
        }
      },
    );
    notifyDataChanged();
  }

  @override
  void onSearchUserEventDone(List<UserProfile> userProfiles) {
    searchUserResult = userProfiles;
    users.addEntries(userProfiles.map((user) => MapEntry(user.id, user)));
    sendSearchVideoEvent(state.widget.searchText,
        userProfile: searchUserResult);
    notifyDataChanged();
  }

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile != null) users[userProfile.id] = userProfile;
    notifyDataChanged();
  }
}

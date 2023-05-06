import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/screens/video/list_video/models/creator_detail.dart';
import 'package:reel_t/screens/video/list_video/models/video_detail.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../events/user/search_user/search_user_event.dart';
import '../../../events/video/search_video/search_video_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import 'show_search_result_screen.dart';

class ShowSearchResultBloc extends AbstractBloc<ShowSearchResultScreenState>
    with SearchUserEvent, SearchVideoEvent, RetrieveUserProfileEvent {
  Map<String, VideoDetail> searchVideoResult = {};
  Map<String, CreatorDetail> creatorDetails = {};
  @override
  void onSearchVideoEventDone(List<Video> videos) {
    searchVideoResult.addEntries(
      videos.map((video) {
        if (!creatorDetails.containsKey(video.creatorId)) {
          sendRetrieveUserProfileEvent(userId: video.creatorId);
        }

        return MapEntry(video.id, VideoDetail(video));
      }),
    );
    notifyDataChanged();
  }

  @override
  void onSearchUserEventDone(List<UserProfile> userProfiles) {
    creatorDetails.addEntries(
      userProfiles.map((user) => MapEntry(user.id, CreatorDetail(user))),
    );
    sendSearchVideoEvent(
      state.widget.searchText,
      userProfile: creatorDetails.values
          .toList()
          .map((creatorDetail) => creatorDetail.userProfile)
          .toList(),
    );
    notifyDataChanged();
  }

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
        
    if (userProfile != null)
      creatorDetails[userProfile.id] = CreatorDetail(userProfile);
    notifyDataChanged();
  }

  String formatUserStatistic(UserProfile userProfile) {
    var formatedNumFollower =
        FormatUtility.formatNumber(userProfile.numFollower);
    var formattedNumLike = FormatUtility.formatNumber(userProfile.numLikes);
    return "${formattedNumLike} follower ${formattedNumLike} likes";
  }
}

import 'package:reel_t/events/follow/follow_user/follow_user_event.dart';
import 'package:reel_t/events/follow/get_follow_user/get_follow_user_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
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
    with
        SearchUserEvent,
        SearchVideoEvent,
        RetrieveUserProfileEvent,
        FollowUserEvent,
        GetFollowUserEvent {
  late UserProfile currentUser;
  bool isLoadDataDone = false;
  Map<String, VideoDetail> searchVideoResult = {};
  Map<String, CreatorDetail> creatorDetails = {};
  @override
  void onSearchVideoEventDone(List<Video> videos) {
    searchVideoResult.addEntries(
      videos.map((video) {
        var creatorId = video.creatorId;
        if (!creatorDetails.containsKey(creatorId)) {
          sendRetrieveUserProfileEvent(userId: creatorId);
        }

        return MapEntry(video.id, VideoDetail(video));
      }),
    );
    isLoadDataDone = true;
    notifyDataChanged();
  }

  @override
  void onSearchUserEventDone(List<UserProfile> userProfiles) {
    creatorDetails.addEntries(
      userProfiles.map((user) {
        sendGetFollowUserEvent(currentUser.id, user.id);
        return MapEntry(user.id, CreatorDetail(user));
      }),
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
    if (userProfile != null) {
      creatorDetails[userProfile.id] = CreatorDetail(userProfile);
      sendGetFollowUserEvent(currentUser.id, userProfile.id);
    }
    notifyDataChanged();
  }

  String formatUserStatistic(UserProfile userProfile) {
    var formatedNumFollower =
        FormatUtility.formatNumber(userProfile.numFollower);
    var formattedNumLike = FormatUtility.formatNumber(userProfile.numLikes);
    return "${formattedNumLike} follower ${formattedNumLike} likes";
  }

  void followUser(CreatorDetail creatorDetail) {
    if (!appStore.localUser.isLogin()) state.pushToScreen(LoginScreen());
    creatorDetail.interactMedia(notifyDataChanged);
    sendFollowUserEvent(creatorDetail.userProfile.id, currentUser.id);
    notifyDataChanged();
  }

  @override
  void onFollowUserEventDone({String userId = "", Follow? follow}) {
    if (follow != null) {
      creatorDetails[follow.userId]?.follow = follow;
      var creatorDetail = creatorDetails[follow.userId];
      creatorDetail!.unlockInteractMedia();
      creatorDetail.cancelRollBack();
      creatorDetail.follow = follow;
      notifyDataChanged();
      notifyDataChanged();
    }
  }

  @override
  void onGetFollowUserEventDone({Follow? follow}) {
    if (follow != null) {
      creatorDetails[follow.userId]?.follow = follow;
    }
  }
}

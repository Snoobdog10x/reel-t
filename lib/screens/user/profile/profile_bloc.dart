import 'package:reel_t/events/video/retrieve_user_video/retrieve_user_video_event.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';

import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ProfileBloc extends AbstractBloc<ProfileScreenState>
    with RetrieveUserVideoEvent {
  List<Video> userVideos = [];
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    notifyDataChanged();
  }

  @override
  void onRetrieveUserVideoEventDone(List<Video> userVideos) {
    this.userVideos.addAll(userVideos);
    notifyDataChanged();
  }
}

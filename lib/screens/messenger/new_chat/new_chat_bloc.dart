import 'package:reel_t/events/user/retrieve_following_user/retrieve_following_user_event.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'new_chat_screen.dart';

class NewChatBloc extends AbstractBloc<NewChatScreenState>
    with RetrieveFollowingUserEvent {
  List<UserProfile> user = [];
  void init() {
    for (int i = 0; i < 10; i++) {
      user.add(UserProfile(
          fullName: 'Do Huy Thong',
          avatar:
              'https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842'));
    }
  }

  @override
  void onRetrieveFollowingUserEventDone(List<UserProfile> userProfiles) {
    // TODO: implement onRetrieveFollowingUserEventDone
    user.addAll(userProfiles);
    notifyDataChanged();
  }
}

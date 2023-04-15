import 'package:reel_t/events/message/create_conversation/create_conversation_event.dart';
import 'package:reel_t/events/user/retrieve_following_user/retrieve_following_user_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/screens/messenger/detail_chat/detail_chat_screen.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'new_chat_screen.dart';

class NewChatBloc extends AbstractBloc<NewChatScreenState>
    with
        RetrieveFollowingUserEvent,
        CreateConversationEvent,
        RetrieveUserProfileEvent {
  List<UserProfile> user = [];
  Conversation? newConversation;
  void init() {
    for (int i = 0; i < 10; i++) {
      user.add(UserProfile(
          fullName: 'Do Huy Thong',
          avatar:
              'https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842'));
    }
  }

  void sendCreateConversation(String userId) {
    state.startLoading();
    sendCreateConversationEvent(appStore.localUser.getCurrentUser().id, userId);
  }

  @override
  void onRetrieveFollowingUserEventDone(List<UserProfile> userProfiles) {
    // TODO: implement onRetrieveFollowingUserEventDone
    user.addAll(userProfiles);
    notifyDataChanged();
  }

  @override
  void onCreateConversationEventDone(Conversation? conversation) {
    if (conversation == null) return;
    this.newConversation = conversation;
    var userIds = List.from(conversation.userIds);
    userIds.remove(appStore.localUser.getCurrentUser().id);
    sendRetrieveUserProfileEvent(userIds.first);
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? ConversationId]) {
    state.stopLoading();
    state.popTopDisplay();
    if (userProfile == null) return;
    state.widget.onCreatedConversation?.call(newConversation!, userProfile);
  }
}

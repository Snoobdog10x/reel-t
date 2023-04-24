import 'package:reel_t/events/message/create_conversation/create_conversation_event.dart';
import 'package:reel_t/events/user/retrieve_conversation_user/retrieve_conversation_user_event.dart';
import 'package:reel_t/events/user/retrieve_following_user/retrieve_following_user_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/events/user/search_user/search_user_event.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/screens/messenger/detail_chat/detail_chat_screen.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'new_chat_screen.dart';

class NewChatBloc extends AbstractBloc<NewChatScreenState>
    with
        RetrieveFollowingUserEvent,
        CreateConversationEvent,
        RetrieveUserProfileEvent,
        RetrieveConversationUserEvent,
        SearchUserEvent {
  List<UserProfile> followingUser = [];
  List<UserProfile> conversationUsers = [];
  List<UserProfile> searchUsers = [];
  Conversation? newConversation;

  void sendCreateConversation(String userId) {
    state.startLoading();
    sendCreateConversationEvent(appStore.localUser.getCurrentUser().id, userId);
  }

  @override
  void onRetrieveFollowingUserEventDone(List<UserProfile> userProfiles) {
    // TODO: implement onRetrieveFollowingUserEventDone
    followingUser.addAll(userProfiles);
    notifyDataChanged();
  }

  @override
  void onCreateConversationEventDone(Conversation? conversation) {
    if (conversation == null) return;
    this.newConversation = conversation;
    var userIds = List.from(conversation.userIds);
    userIds.remove(appStore.localUser.getCurrentUser().id);
    sendRetrieveUserProfileEvent(userId: userIds.first);
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? ConversationId]) {
    state.stopLoading();
    state.popTopDisplay();
    if (userProfile == null) return;
    state.widget.onCreatedConversation?.call(newConversation!, userProfile);
  }

  @override
  void onRetrieveConversationUserEventDone(List<UserProfile> userProfiles) {
    conversationUsers = userProfiles;
    notifyDataChanged();
  }

  @override
  void onSearchUserEventDone(List<UserProfile> userProfiles) {
    searchUsers = userProfiles;
    notifyDataChanged();
  }
}

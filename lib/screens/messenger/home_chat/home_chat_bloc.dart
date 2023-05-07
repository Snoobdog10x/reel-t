import 'package:reel_t/shared_product/vendors/collection/priority_set/priority_set.dart';

import '../../../events/message/stream_conversations/stream_conversations_event.dart';
import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/message/message.dart';
import '../../../models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import 'home_chat_screen.dart';

class HomeChatBloc extends AbstractBloc<HomeChatScreenState>
    with StreamConversationsEvent, RetrieveUserProfileEvent {
  PrioritySet<Conversation> conversations = new PrioritySet((p0, p1) {
    if (p0.updateAt < p1.updateAt) return 1;
    if (p0.updateAt > p1.updateAt) return -1;
    return 0;
  });

  Conversation? addedConversation;
  UserProfile? addedUserProfile;
  Map<String, UserProfile> contactUsers = {};
  late UserProfile currentUser;
  void init() {
    if (!appStore.localUser.isLogin()) return;
    currentUser = appStore.localUser.getCurrentUser();
    sendStreamConversationsEvent(currentUser.id);
    notifyDataChanged();
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? conversationId]) {
    if (e.isEmpty) {
      contactUsers[conversationId!] = userProfile!;
      notifyDataChanged();
    }
  }

  bool isLoadData(Conversation conversation) {
    return contactUsers[conversation.id] != null;
  }

  bool isCurrentUserMessage(Message message) {
    if (message.userId == currentUser.id) return true;
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeStreamConversationsEvent();
  }

  @override
  void onStreamConversationsEventDone(List<Conversation> updatedConversations) {
    for (var conversation in updatedConversations) {
      conversations.add(conversation);
      var userIds = List.from(conversation.userIds);
      userIds.remove(currentUser.id);
      var secondUserId = userIds.first;
      if (contactUsers[secondUserId] == null)
        sendRetrieveUserProfileEvent(
          userId: secondUserId,
          conversationId: conversation.id,
        );
      notifyDataChanged();
    }
  }
}

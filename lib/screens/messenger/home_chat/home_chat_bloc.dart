import 'dart:convert';
import 'dart:math';
import '../../../events/message/retrieve_messages/retrieve_messages_event.dart';
import '../../../events/message/stream_conversations/stream_conversations_event.dart';
import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/message/message.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/services/local_storage.dart';

import '../../../generated/abstract_bloc.dart';
import 'home_chat_screen.dart';

class HomeChatBloc extends AbstractBloc<HomeChatScreenState>
    with StreamConversationsEvent, RetrieveUserProfileEvent {
  List<Conversation> conversations = [];
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
  void onRetrieveConversationsEventDone(
      e, List<Conversation> updatedConversations) {
    if (e == null) {
      for (var conversation in updatedConversations) {
        if (!_isConversationExists(conversation)) {
          conversations.add(conversation);
          var secondUserId = conversation.userIds
              .firstWhere((element) => element != currentUser.id);
          sendRetrieveUserProfileEvent(
            userId: secondUserId,
            conversationId: conversation.id,
          );
        } else {
          mergeConversation(conversation);
        }
        conversations.sort(((a, b) {
          if (a.updateAt < b.updateAt) return 1;
          if (a.updateAt == b.updateAt) return 0;
          return -1;
        }));
        notifyDataChanged();
      }
    }
  }

  void mergeConversation(Conversation conversation) {
    conversations.removeWhere(((element) => element.id == conversation.id));
    conversations.add(conversation);
  }

  bool _isConversationExists(Conversation conversation) {
    return conversations.any((element) => element.id == conversation.id);
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
      if (!_isConversationExists(conversation)) {
        conversations.add(conversation);
        var userIds = List.from(conversation.userIds);
        userIds.remove(currentUser.id);
        var secondUserId = userIds.first;
        sendRetrieveUserProfileEvent(
          userId: secondUserId,
          conversationId: conversation.id,
        );
      } else {
        mergeConversation(conversation);
      }
      conversations.sort((a, b) => _compareConversation(a, b));
      notifyDataChanged();
    }
  }

  int _compareConversation(Conversation a, Conversation b) {
    if (a.updateAt < b.updateAt) return 1;
    if (a.updateAt == b.updateAt) return 0;
    return -1;
  }
}

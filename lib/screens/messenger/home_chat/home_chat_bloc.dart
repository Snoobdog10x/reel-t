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
  late UserProfile currentUser;
  void init() {
    if (!appStore.localUser.isLogin()) return;
    currentUser = appStore.localUser.getCurrentUser();
    if (appStore.localMessenger.isExistsConversations()) {
      conversations = appStore.localMessenger.getConversations();
      print(appStore.localMessenger.getConversations());
    }
    sendStreamConversationsEvent(currentUser.id);
    notifyDataChanged();
  }

  @override
  void onRetrieveConversationsEventDone(
      e, List<Conversation> updatedConversations) {
    if (e == null) {
      print(updatedConversations);
      for (var conversation in updatedConversations) {
        if (!_isConversationExists(conversation)) {
          conversations.add(conversation);
          var secondUserId = conversation.userIds
              .firstWhere((element) => element != currentUser.id);
          sendRetrieveUserProfileEvent(secondUserId, conversation.id);
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
    conversation.contactUser = conversations
        .firstWhere((element) => element.id == conversation.id)
        .contactUser;
    conversations.removeWhere(((element) => element.id == conversation.id));
    conversations.add(conversation);
  }

  bool _isConversationExists(Conversation conversation) {
    return conversations.any((element) => element.id == conversation.id);
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? conversationId]) {
    if (e == null) {
      conversations
          .firstWhere((element) => element.id == conversationId)
          .contactUser
          .add(userProfile!);
    }
    notifyDataChanged();
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
        var secondUserId = conversation.userIds
            .firstWhere((element) => element != currentUser.id);
        sendRetrieveUserProfileEvent(secondUserId, conversation.id);
      } else {
        mergeConversation(conversation);
      }
      conversations.sort((a, b) => _compareConversation(a, b));
      notifyDataChanged();
    }
    syncConversations();
  }

  void syncConversations() {
    if (conversations.length >= 15) {
      appStore.localMessenger
          .saveConversations(conversations.getRange(0, 14).toList());
      return;
    }
    appStore.localMessenger.saveConversations(conversations);
  }

  int _compareConversation(Conversation a, Conversation b) {
    if (a.updateAt < b.updateAt) return 1;
    if (a.updateAt == b.updateAt) return 0;
    return -1;
  }
}

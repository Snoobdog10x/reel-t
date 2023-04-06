import 'dart:convert';
import 'dart:math';

import 'package:reel_t/events/message/retrieve_conversations/retrieve_conversations_event.dart';
import 'package:reel_t/events/message/retrieve_messages/retrieve_messages_event.dart';
import 'package:reel_t/events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

import '../../../generated/abstract_bloc.dart';
import 'home_chat_screen.dart';

class HomeChatBloc extends AbstractBloc<HomeChatScreenState>
    with RetrieveConversationsEvent, RetrieveUserProfileEvent {
  List<Conversation> conversations = [];
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    if (appStore.localMessenger.isExistsConversations()) {
      conversations = appStore.localMessenger.getConversations();
    }
    sendRetrieveConversationsEvent(currentUser);
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

  @override
  void onRetrieveMessagesEventDone(e) {
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
    disposeRetrieveConversationsEvent();
  }
}

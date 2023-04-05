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

class HomeChatBloc extends AbstractBloc
    with
        RetrieveConversationsEvent,
        RetrieveUserProfileEvent,
        RetrieveMessagesEvent {
  Map<String, Conversation> conversations = new Map<String, Conversation>();
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    if (appStore.localMessenger.isExistsConversations()) {
      for (var conversation in appStore.localMessenger.getConversations()) {
        conversations[conversation.id] = conversation;
      }
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
        if (!_isContainConversation(conversation)) {
          this.conversations[conversation.id] = conversation;
          var secondUserId = conversation.userIds
              .firstWhere((element) => element != currentUser.id);
          sendRetrieveUserProfileEvent(secondUserId, conversation.id);
          sendRetrieveMessagesEvent(conversation);
        }
      }
    }
  }

  bool _isContainConversation(Conversation conversation) {
    return conversations[conversation.id] != null;
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? conversationId]) {
    if (e == null) {
      conversations[conversationId]!.secondUser.add(userProfile!);
    }
    notifyDataChanged();
  }

  @override
  void onRetrieveMessagesEventDone(e) {
    notifyDataChanged();
  }
}

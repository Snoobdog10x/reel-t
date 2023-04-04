import 'dart:convert';
import 'dart:math';

import 'package:reel_t/events/message/retrieve_conversations/retrieve_conversations_event.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

import '../../../generated/abstract_provider.dart';

class HomeChatProvider extends AbstractProvider
    with RetrieveConversationsEvent {
  Map<String, Conversation> conversations = new Map<String, Conversation>();
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;
    print('sync data');
    if (appStore.localMessenger.isExistsConversations()) {
      for (var conversation in appStore.localMessenger.getConversations()) {
        conversations[conversation.id] = conversation;
      }
    }
    sendRetrieveConversationsEventEvent(currentUser);
    notifyDataChanged();
  }

  @override
  void onRetrieveConversationsEventDone(e) {
    // TODO: implement onRetrieveConversationsEventDone
  }
}

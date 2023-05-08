import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/conversation/conversation.dart';

abstract class StreamConversationsEvent {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _conversationStream;
  void sendStreamConversationsEvent(String currentUserId) {
    disposeStreamConversationsEvent();
    disposeStreamConversationsEvent();
    try {
      _createStreamConversations(currentUserId);
    } catch (e) {
      print("StreamConversationsEvent $e");
      onStreamConversationsEventDone([]);
    }
  }

  void _createStreamConversations(String currentUserId) {
    final db = FirebaseFirestore.instance.collection(Conversation.PATH);
    _conversationStream = db
        .where(Conversation.userIds_PATH, arrayContains: currentUserId)
        .orderBy(Conversation.updateAt_PATH, descending: true)
        .limit(15)
        .snapshots()
        .listen(
      (event) {
        var docs = event.docChanges;
        List<Conversation> conversations = [];
        for (var doc in docs) {
          var newConv = Conversation.fromJson(doc.doc.data()!);
          conversations.add(newConv);
        }
        onStreamConversationsEventDone(conversations);
      },
    );
  }

  void disposeStreamConversationsEvent() {
    _conversationStream?.cancel();
  }

  void onStreamConversationsEventDone(List<Conversation> updatedConversations);
}

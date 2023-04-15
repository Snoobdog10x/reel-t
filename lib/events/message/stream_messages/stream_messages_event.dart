import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/conversation/conversation.dart';
import '../../../models/message/message.dart';

abstract class StreamMessagesEvent {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _streamMessages;
  void sendStreamMessagesEvent(String conversationId) {
    try {
      final db = FirebaseFirestore.instance.collection(Conversation.PATH);
      _streamMessages = db
          .doc(conversationId)
          .collection(Message.PATH)
          .orderBy(Message.createAt_PATH, descending: true)
          .limit(15)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        List<Message> messages = [];
        docs.forEach((doc) {
          if (doc.type == DocumentChangeType.added) {
            messages.insert(0, Message.fromJson(doc.doc.data()!));
          }
        });
        onStreamMessagesEventDone(messages);
      });
    } catch (e) {
      onStreamMessagesEventDone([]);
    }
  }

  void disposeStreamMessagesEvent() {
    _streamMessages?.cancel();
  }

  void onStreamMessagesEventDone(List<Message> newMessages);
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/conversation/conversation.dart';

abstract class RetrieveMessagesEvent {
  final db = FirebaseFirestore.instance.collection(Conversation.PATH);
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      streamMessages;
  void sendRetrieveMessagesEvent(Conversation conversation) {
    disposeRetrieveMessagesEvent();
    try {
      streamMessages = db
          .doc(conversation.id)
          .collection(Message.PATH)
          .orderBy(Message.createAt_PATH)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        List<Message> messages = [];
        docs.forEach((doc) {
          if (doc.type == DocumentChangeType.added) {
            messages.insert(0, Message.fromJson(doc.doc.data()!));
          }
        });
        onRetrieveMessagesEventDone(messages);
      });
    } catch (e) {
      print("RetrieveMessagesEvent $e");
      onRetrieveMessagesEventDone([]);
    }
  }

  void onRetrieveMessagesEventDone(List<Message> newMessage);
  void disposeRetrieveMessagesEvent() {
    streamMessages.cancel();
  }
}

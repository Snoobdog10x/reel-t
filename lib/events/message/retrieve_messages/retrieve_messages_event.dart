import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/video/video.dart';

import '../../../models/conversation/conversation.dart';

abstract class RetrieveMessagesEvent {
  final db = FirebaseFirestore.instance.collection(Conversation.PATH);
  void sendRetrieveMessagesEventEvent(Conversation conversation) {
    try {
      db
          .doc(conversation.id)
          .collection(Message.PATH)
          .orderBy(Message.createAt_PATH)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        docs.forEach((doc) {
          if (doc.type == DocumentChangeType.added) {
            conversation.messages.add(Message.fromJson(doc.doc.data()!));
          }
        });
      });
      onRetrieveMessagesEventDone(null);
    } catch (e) {
      onRetrieveMessagesEventDone(e);
    }
  }

  void onRetrieveMessagesEventDone(dynamic e);
}

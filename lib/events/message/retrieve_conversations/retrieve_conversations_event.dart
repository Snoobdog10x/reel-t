import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveConversationsEvent {
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      conversationStream;
  void sendRetrieveConversationsEvent(UserProfile currentUser) {
    try {
      final db = FirebaseFirestore.instance.collection(Conversation.PATH);
      conversationStream = db
          .where(Conversation.userIds_PATH, arrayContains: currentUser.id)
          .orderBy(Conversation.updateAt_PATH, descending: true)
          .limit(15)
          .snapshots()
          .listen((event) async {
        var docs = event.docChanges;
        List<Conversation> conversations = [];
        for (var doc in docs) {
          var newConv = Conversation.fromJson(doc.doc.data()!);
          var snapshot = await db
              .doc(newConv.id)
              .collection(Message.PATH)
              .orderBy(Message.createAt_PATH, descending: true)
              .limit(1)
              .get();
          newConv.latestMessage
              .add(Message.fromJson(snapshot.docs.first.data()));
          conversations.add(newConv);
        }

        onRetrieveConversationsEventDone(null, conversations);
      });
    } catch (e) {
      onRetrieveConversationsEventDone(e, []);
    }
  }

  void disposeRetrieveConversationsEvent() {
    conversationStream.cancel();
  }

  void onRetrieveConversationsEventDone(
      dynamic e, List<Conversation> conversation);
}

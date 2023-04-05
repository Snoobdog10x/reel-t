import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveConversationsEvent {
  void sendRetrieveConversationsEvent(UserProfile currentUser) {
    try {
      final db = FirebaseFirestore.instance.collection(Conversation.PATH);
      db
          .where(Conversation.userIds_PATH, arrayContains: currentUser.id)
          .orderBy(Conversation.updateAt_PATH, descending: true)
          .limit(15)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        List<Conversation> conversations = [
          for (var doc in docs) Conversation.fromJson(doc.doc.data()!)
        ];
        onRetrieveConversationsEventDone(null, conversations);
      });
    } catch (e) {
      onRetrieveConversationsEventDone(e, []);
    }
  }

  void onRetrieveConversationsEventDone(
      dynamic e, List<Conversation> conversation);
}

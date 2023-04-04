import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveConversationsEvent {
  final db = FirebaseFirestore.instance;
  void sendRetrieveConversationsEventEvent(UserProfile currentUser) {
    try {
      db
          .collection(Conversation.PATH)
          .where('userIds', arrayContains: currentUser.id)
          .orderBy('updateAt', descending: true)
          .limit(15)
          .snapshots()
          .listen((event) {
        var docs = event.docChanges;
        print([for (var doc in docs) Conversation.fromJson(doc.doc.data()!)]);
        onRetrieveConversationsEventDone(null);
      });
    } catch (e) {
      onRetrieveConversationsEventDone(e);
    }
  }

  void onRetrieveConversationsEventDone(dynamic e);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveConversationsEvent {
  final db = FirebaseFirestore.instance;
  void sendRetrieveConversationsEventEvent(UserProfile currentUser) {
    try {
      db
          .collection(Conversation.PATH)
          .where('firstUserId', isEqualTo: currentUser.id)
          .orderBy('createAt', descending: true)
          .limitToLast(15)
          .snapshots()
          .listen((event) {
        var docs = event.docs;
        print([for (var doc in docs) Conversation.fromJson(doc.data())]);
        onRetrieveConversationsEventDone(null);
      });
    } catch (e) {
      onRetrieveConversationsEventDone(e);
    }
  }

  void onRetrieveConversationsEventDone(dynamic e);

  // Future<Like> _retrieveLike(String videoId, String currentUserId) async {
  //   var snapshot = await db
  //       .collection(Video.PATH)
  //       .doc(videoId)
  //       .collection(Like.PATH)
  //       .where("userId", isEqualTo: currentUserId)
  //       .get();
  //   var docs = snapshot.docs;
  //   if (docs.isEmpty) {
  //     return Like(videoId: videoId, userId: currentUserId);
  //   }
  //   return Like.fromJson(docs.first.data());
  // }
}

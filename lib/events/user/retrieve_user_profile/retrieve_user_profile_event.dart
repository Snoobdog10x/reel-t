import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveUserProfileEvent {
  Future<void> sendRetrieveUserProfileEvent(String userID,
      [String? conversationId]) async {
    try {
      final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
      var snapshot = await db.doc(userID).get();
      if (!snapshot.exists) {
        onRetrieveUserProfileEventDone("not found User", null, conversationId);
      }
      onRetrieveUserProfileEventDone(
          null, UserProfile.fromJson(snapshot.data()!), conversationId);
    } catch (e) {
      onRetrieveUserProfileEventDone(e, null, conversationId);
    }
  }

  void onRetrieveUserProfileEventDone(dynamic e, UserProfile? userProfile,
      [String? ConversationId]);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveUserProfileEvent {
  Future<void> sendRetrieveUserProfileEvent({
    String? userId,
    String? conversationId,
    String? email,
  }) async {
    try {
      var user = await _retrieveUserProfile(userId: userId, email: email);
      if (user == null) {
        onRetrieveUserProfileEventDone("not found User", user, conversationId);
      }

      onRetrieveUserProfileEventDone("", user, conversationId);
    } catch (e) {
      print(e);
      onRetrieveUserProfileEventDone(e.toString(), null, conversationId);
    }
  }

  Future<UserProfile?> _retrieveUserProfile({
    String? userId,
    String? email,
  }) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (email != null && email.isNotEmpty)
      snapshot = await db.where(UserProfile.email_PATH, isEqualTo: email).get();
    else
      snapshot = await db.where(UserProfile.id_PATH, isEqualTo: userId).get();

    if (snapshot.docs.isEmpty) return null;
    return UserProfile.fromJson(snapshot.docs.first.data());
  }

  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]);
}

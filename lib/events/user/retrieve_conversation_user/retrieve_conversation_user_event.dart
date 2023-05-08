import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class RetrieveConversationUserEvent {
  Future<void> sendRetrieveConversationUserEvent(String userId) async {
    try {
      var conversations = await _getConversations(userId);
      var userProfiles = await _getUserProfiles(conversations, userId);
      onRetrieveConversationUserEventDone(userProfiles);
    } catch (e) {
      print("RetrieveConversationUserEvent $e");
      onRetrieveConversationUserEventDone([]);
    }
  }

  Future<List<Conversation>> _getConversations(String userId) async {
    final db = FirebaseFirestore.instance.collection(Conversation.PATH);
    var snapshot = await db
        .orderBy(Conversation.userIds_PATH)
        .where(Conversation.userIds_PATH, arrayContains: userId)
        .limit(4)
        .get();
    var docs = snapshot.docs;
    if (docs.isEmpty) return [];
    return docs.map((e) => Conversation.fromJson(e.data())).toList();
  }

  Future<UserProfile?> _getUserProfile(
      Conversation conver, String userId) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    conver.userIds.remove(userId);
    var anotherUserId = conver.userIds.first;
    var snapshot = await db.doc(anotherUserId).get();
    if (!snapshot.exists) return null;

    return UserProfile.fromJson(snapshot.data()!);
  }

  Future<List<UserProfile>> _getUserProfiles(
      List<Conversation> convers, String userId) async {
    List<Future<UserProfile?>> futureProfiles = [];
    convers.forEach((element) {
      final db = FirebaseFirestore.instance.collection(Conversation.PATH);
      futureProfiles.add(_getUserProfile(element, userId));
    });

    var userProfiles = await Future.wait(futureProfiles);
    return userProfiles.whereType<UserProfile>().toList();
  }

  void onRetrieveConversationUserEventDone(List<UserProfile> userProfiles);
}

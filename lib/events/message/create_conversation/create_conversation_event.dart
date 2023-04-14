import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';
import 'package:collection/collection.dart';

abstract class CreateConversationEvent {
  Future<void> sendCreateConversationEvent(
      String currentUserId, String userId) async {
    try {
      var conversation = await _createConversation(currentUserId, userId);
      onCreateConversationEventDone(conversation);
    } catch (e) {
      onCreateConversationEventDone(null);
      print(e);
    }
  }

  Future<Conversation> _createConversation(
      String currentUserId, String userId) async {
    var conversation = await _getConversationExists(currentUserId, userId);
    if (conversation != null) return conversation;

    final db = FirebaseFirestore.instance.collection(Conversation.PATH);
    var id = db.doc().id;
    var newConversation = Conversation(
      id: id,
      userIds: [currentUserId, userId],
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    await db.doc(id).set(newConversation.toJson());
    return newConversation;
  }

  Future<Conversation?> _getConversationExists(
      String currentUserId, String userId) async {
    final db = FirebaseFirestore.instance.collection(Conversation.PATH);
    var snapshot = await db
        .where(Conversation.userIds_PATH, arrayContains: currentUserId)
        .get();
    if (snapshot.docs.isEmpty) return null;
    var conversationSnapshot = snapshot.docs.firstWhereOrNull((element) {
      var conversation = Conversation.fromJson(element.data());
      return conversation.userIds.contains(userId);
    });
    if (conversationSnapshot == null) return null;

    return Conversation.fromJson(conversationSnapshot.data());
  }

  void onCreateConversationEventDone(Conversation? conversation);
}

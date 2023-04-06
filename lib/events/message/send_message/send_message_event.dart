import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';

import '../../../shared_product/utils/format_utlity.dart';

abstract class SendMessageEvent {
  final _db = FirebaseFirestore.instance.collection(Conversation.PATH);
  Future<void> sendSendMessageEvent(
      Conversation conversation, Message message) async {
    try {
      var conversationRef = _db.doc(conversation.id);
      var messageRef = conversationRef.collection(Message.PATH).doc();
      var id = messageRef.id;
      final batch = FirebaseFirestore.instance.batch();
      batch.set(conversationRef, conversation);
      conversation.updateAt = FormatUtility.getMillisecondsSinceEpoch();
      message.id = id;
      batch.set(messageRef, message);
      await batch.commit();
      onSendMessageEventDone(null);
    } catch (e) {
      onSendMessageEventDone(e);
    }
  }

  void onSendMessageEventDone(dynamic e);
}

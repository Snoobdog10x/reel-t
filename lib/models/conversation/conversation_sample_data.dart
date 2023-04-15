import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/message/message_sample_data.dart';
import '../../shared_product/utils/format/format_utlity.dart';
import 'conversation.dart';

import '../message/message.dart';

class ConversationData {
  Future<void> initConversationData() async {
    for (int i = 0; i < 10; i++) {
      var conversation = Conversation(
        id: i.toString(),
        userIds: ["Pg8GacuZI2aqJRXLBDmXXZqGVwo1", i.toString()],
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
        updateAt: FormatUtility.getMillisecondsSinceEpoch(),
      );
      final db = FirebaseFirestore.instance;
      db
          .collection(Conversation.PATH)
          .doc(i.toString())
          .set(conversation.toJson());
      var latestMessage = MessageData().initMessageData(conversation);
      conversation.latestMessage = latestMessage.toStringJson();
      db
          .collection(Conversation.PATH)
          .doc(i.toString())
          .set(conversation.toJson());
    }
  }
}

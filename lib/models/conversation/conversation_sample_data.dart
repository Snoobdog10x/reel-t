import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/message/message_sample_data.dart';
import '../../shared_product/utils/format_utlity.dart';
import 'conversation.dart';

import '../message/message.dart';

class ConversationData {
  Future<void> initConversationData() async {
    for (int i = 0; i < 10; i++) {
      var conversation = Conversation(
        id: i.toString(),
        userIds: ["LhL5EUNo7NdTQzaIhM9kgQkdIAh2", i.toString()],
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
        updateAt: FormatUtility.getMillisecondsSinceEpoch(),
      );
      final db = FirebaseFirestore.instance;
      db
          .collection(Conversation.PATH)
          .doc(i.toString())
          .set(conversation.toJson());
      MessageData().initMessageData(conversation);
    }
  }
}

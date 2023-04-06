import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      addMessageToConversation(conversation);
      final db = await FirebaseFirestore.instance;
      db
          .collection(Conversation.PATH)
          .doc(i.toString())
          .set(conversation.toJson());
      var messages = conversation.messages;
      for (var message in messages) {
        db
            .collection(Conversation.PATH)
            .doc(i.toString())
            .collection(Message.PATH)
            .doc(messages.indexOf(message).toString())
            .set(message.toJson());
      }
    }
  }

  void addMessageToConversation(Conversation conversation) {
    Random random = Random();
    List<String> contents = [
      "hihi",
      "Chao em",
      "Em khoe khong",
      "Random ..... randsadasdasdasdasdasdasd12321321312qsdfasdfafdsfsdfdsdfdsf",
      "dadasdhiuasiudhaiushdoasodn12312312",
      "sdasdas",
      "sdasdasdasdaasfaf12312312ksakmdkaskdmas",
      "11111111 hihihi ",
    ];
    List<Message> messages = [];
    for (int i = 0; i < 15; i++) {
      var content = contents[random.nextInt(contents.length)];
      var userId =
          conversation.userIds[random.nextInt(conversation.userIds.length)];
      messages.add(
        Message(
          id: i.toString(),
          userId: userId,
          content: content,
          createAt: FormatUtility.getMillisecondsSinceEpoch(),
        ),
      );
    }
    conversation.messages.addAll(messages);
  }
}

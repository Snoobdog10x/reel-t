import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared_product/utils/format/format_utlity.dart';
import '../conversation/conversation.dart';
import 'message.dart';

class MessageData {
  final db = FirebaseFirestore.instance;
  Message initMessageData(Conversation conversation) {
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
    var message;
    for (int i = 0; i < 15; i++) {
      var content = contents[random.nextInt(contents.length)];
      var userId =
          conversation.userIds[random.nextInt(conversation.userIds.length)];
      message = Message(
        id: i.toString(),
        userId: userId,
        content: content,
        hasSeen: true,
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
      );
      db
          .collection(Conversation.PATH)
          .doc(conversation.id)
          .collection(Message.PATH)
          .doc(i.toString())
          .set(message.toJson());
    }
    return message;
  }
}

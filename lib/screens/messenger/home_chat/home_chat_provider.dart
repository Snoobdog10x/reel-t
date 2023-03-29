import 'dart:math';

import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_provider.dart';

class HomeChatProvider extends AbstractProvider {
  String USER_KEY = "user";
  String CONVERSATION_KEY = "conversation";
  List<Conversation> conversations = [];
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  void init() {
    UserProfile user =
        UserProfile(id: "0", fullName: "Nguyen Duy Thanh", avatar: avatar);
    UserProfile user2 =
        UserProfile(id: "1", fullName: "Do Huy Thong", avatar: avatar);
    for (int i = 0; i < 10; i++) {
      Conversation conversation = Conversation(
        id: i.toString(),
        secondUserId: i.toString(),
      );
      conversation.user1 = user;
      conversation.user2 = user2;
      addMessageToConvert(conversation);
      conversations.add(conversation);
    }
    notifyDataChanged();
  }

  void addMessageToConvert(Conversation conversation) {
    Random random = Random();
    List<String> userIds = [conversation.user1!.id, conversation.user2!.id];
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
      var userId = userIds[random.nextInt(userIds.length)];
      messages.add(
        Message(
          id: i.toString(),
          userId: userId,
          content: content,
        ),
      );
    }
    conversation.messages.addAll(messages);
  }
}

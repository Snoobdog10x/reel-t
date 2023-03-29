import 'dart:convert';
import 'dart:math';

import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';

import '../../../generated/abstract_provider.dart';

class HomeChatProvider extends AbstractProvider {
  String USER_KEY = "user_key";
  String CONVERSATION_KEY = "conversation";
  String MESSAGES_KEY = "MESSAGES_KEY";
  List<Conversation> conversations = [];
  late UserProfile currentUser;
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    print("local");
    getLocalConversations();
    if (conversations.isEmpty) {
      print("mockdata");
      addMockData();
    }
    notifyDataChanged();
  }

  void addMockData() {
    UserProfile user2 =
        UserProfile(id: "1", fullName: "Do Huy Thong", avatar: avatar);
    for (int i = 0; i < 10; i++) {
      Conversation conversation = Conversation(
        id: i.toString(),
        secondUserId: i.toString(),
      );
      conversation.user1 = currentUser;
      conversation.user2 = user2;
      addMessageToConversation(conversation);
      conversations.add(conversation);
    }
  }

  void addMessageToConversation(Conversation conversation) {
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

  void setLocalConversations() async {
    List<String> conversationsString = [];
    var revertConversations = conversations.reversed.toList();
    for (var conversation in revertConversations.getRange(0, 10)) {
      Map<String, String> conversationMap = {};
      var messagesString = json.encode(conversation.messages);
      conversationMap[MESSAGES_KEY] = messagesString;
      conversationMap[CONVERSATION_KEY] = conversation.toStringJson();
      conversationMap[USER_KEY] = conversation.user2!.toStringJson();
      conversationsString.add(json.encode(conversationMap));
    }
    appStore.localStorage
        .setListCache(LocalStorage.CONVERSATIONS_KEY, conversationsString);
  }

  void getLocalConversations() {
    var listStringConversation = appStore.localStorage
        .getListStringCache(LocalStorage.CONVERSATIONS_KEY);
    for (var conversationSting in listStringConversation) {
      Map conversationMap = json.decode(conversationSting);
      conversations.add(_loadLocalConversation(conversationMap));
    }
    notifyDataChanged();
  }

  Conversation _loadLocalConversation(Map conversationMap) {
    List<dynamic> messageStrings = json.decode(conversationMap[MESSAGES_KEY]!);
    Conversation conversation =
        Conversation.fromJson(json.decode(conversationMap[CONVERSATION_KEY]!));
    conversation.messages = [
      for (var message in messageStrings) Message.fromJson(message)
    ];
    conversation.user1 = currentUser;
    conversation.user2 = UserProfile.fromStringJson(conversationMap[USER_KEY]);
    return conversation;
  }
}

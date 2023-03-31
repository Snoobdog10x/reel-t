import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_provider.dart';
import '../../../models/conversation/conversation.dart';

class DetailChatScreenProvider extends AbstractProvider {
  late Conversation conversation;
  late UserProfile currentUser;
  void init(Conversation conversation) {
    this.conversation = conversation;
    currentUser = appStore.localUser.getCurrentUser();
    // print(conversation.messages);
    print(currentUser);
  }

  bool isCurrentUserMessage(Message message) {
    if (message.userId == currentUser.id) return true;
    return false;
  }
}

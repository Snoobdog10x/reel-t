import '../../../generated/abstract_provider.dart';
import '../../../models/conversation/conversation.dart';

class DetailChatScreenProvider extends AbstractProvider {
  late Conversation conversation;
  void init(Conversation conversation) {
    this.conversation = conversation;
    print(conversation.messages);
  }
}

import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';

class DetailChatScreenBloc extends AbstractBloc {
  late Conversation conversation;
  late UserProfile currentUser;
  late UserProfile contactUser;
  void init(Conversation conversation) {
    this.conversation = conversation;
    currentUser = appStore.localUser.getCurrentUser();
    contactUser = conversation.secondUser.first;
  }

  bool isCurrentUserMessage(Message message) {
    if (message.userId == currentUser.id) return true;
    return false;
  }
}

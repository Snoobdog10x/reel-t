import '../../../generated/abstract_bloc.dart';

import '../../../models/conversation/conversation.dart';
import '../../../models/message/message.dart';
import '../../../models/user_profile/user_profile.dart';
import 'detail_chat_setting_screen.dart';

class DetailChatSettingBloc extends AbstractBloc<DetailChatSettingScreenState> {
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

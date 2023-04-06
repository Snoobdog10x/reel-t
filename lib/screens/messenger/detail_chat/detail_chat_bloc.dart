import 'package:reel_t/events/message/retrieve_messages/retrieve_messages_event.dart';
import 'package:reel_t/events/message/send_message/send_message_event.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/utils/format_utlity.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import 'detail_chat_screen.dart';

class DetailChatScreenBloc extends AbstractBloc<DetailChatScreenScreenState>
    with SendMessageEvent, RetrieveMessagesEvent {
  late Conversation conversation;
  late UserProfile currentUser;
  late UserProfile contactUser;
  List<Message> messages = [];
  void sendMessage(String content) {
    Message message = Message(
        userId: currentUser.id,
        content: content,
        createAt: FormatUtility.getMillisecondsSinceEpoch());
    sendSendMessageEvent(conversation, message);
  }

  bool isCurrentUserMessage(Message message) {
    if (message.userId == currentUser.id) return true;
    return false;
  }

  @override
  void onSendMessageEventDone(e, [Conversation? conversation]) {
    if (e != null) {
      this.conversation = conversation!;
    }
    notifyDataChanged();
  }

  @override
  void dispose() {
    super.dispose();
    disposeRetrieveMessagesEvent();
    disposeSendMessageEvent();
  }

  @override
  void onRetrieveMessagesEventDone(List<Message> newMessages) {
    messages.insertAll(0, newMessages);
    notifyDataChanged();
  }
}

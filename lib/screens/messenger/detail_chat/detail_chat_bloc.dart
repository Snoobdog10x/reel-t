import 'dart:convert';
import 'dart:math';

import 'package:reel_t/events/message/retrieve_messages/retrieve_messages_event.dart';
import 'package:reel_t/events/message/send_message/send_message_event.dart';
import 'package:reel_t/events/message/stream_messages/stream_messages_event.dart';
import 'package:reel_t/events/notification/push_notification/push_notification_event.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/notification/notification.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/receive_notification.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import 'detail_chat_screen.dart';

class DetailChatScreenBloc extends AbstractBloc<DetailChatScreenScreenState>
    with SendMessageEvent, StreamMessagesEvent, PushNotificationEvent {
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
    sendPushNotificationEvent(
      userId: contactUser.id,
      notificationContent: json.encode({
        ReceiveNotification.NEW_MESSAGE_KEY: conversation.latestMessage,
        ReceiveNotification.CONTACT_USER_KEY: contactUser.toStringJson(),
        ReceiveNotification.PUSH_CONVERSATION_KEY: conversation.toStringJson(),
      }),
      type: NotificationType.NEW_MESSAGE,
    );
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
    disposeStreamMessagesEvent();
  }

  @override
  void onStreamMessagesEventDone(List<Message> newMessages) {
    newMessages.forEach((element) {
      messages.insert(0, element);
    });

    notifyDataChanged();
  }

  @override
  void onPushNotificationEventDone(Notification? notification) {
    // TODO: implement onPushNotificationEventDone
  }
}

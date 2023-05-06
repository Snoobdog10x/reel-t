import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/notification/notification.dart';

import '../../events/notification/retrieve_notification_nums/retrieve_notification_nums_event.dart';
import '../../events/notification/stream_user_notification/stream_user_notification_event.dart';
import '../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../generated/abstract_bloc.dart';
import '../../models/message/message.dart';
import '../../models/user_profile/user_profile.dart';
import 'notification_screen.dart';

class NotificationBloc extends AbstractBloc<NotificationScreenState>
    with StreamUserNotificationEvent, RetrieveUserProfileEvent {
  List<Notification> listNotification = [];
  Map<String, UserProfile> contactUser = {};
  late UserProfile currentUser;

  void init() {
    if (!appStore.localUser.isLogin()) return;
    currentUser = appStore.localUser.getCurrentUser();
    sendStreamUserNotificationEvent(currentUser.id);
    notifyDataChanged();
  }

  Message parseNotificationToMessage(Notification notification) {
    var parsedData = parseNotificationToMapData(notification);
    var messageString = parsedData["new_message_key"];
    return Message.fromStringJson(messageString ?? '');
  }

  Map parseNotificationToMapData(Notification notification) {
    return json.decode(notification.notificationContent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeStreamUserNotificationEvent();
    super.dispose();
  }

  @override
  void onStreamUserNotificationEventDone(List<Notification> userNotifications) {
    listNotification.addAll(userNotifications);
    notifyDataChanged();
    state.widget.callBackNewNotification?.call();
    listNotification.forEach((notification) {
      var message = parseNotificationToMessage(notification);
      if (contactUser[message.userId] == null)
        sendRetrieveUserProfileEvent(userId: message.userId);
    });
    // TODO: implement onStreamUserNotificationEventDone
  }

  @override
  void onRetrieveUserProfileEventDone(String e, UserProfile? userProfile,
      [String? ConversationId]) {
    if (userProfile != null) contactUser[userProfile.id] = userProfile;
    notifyDataChanged();
    // TODO: implement onRetrieveUserProfileEventDone
  }
}

import 'package:reel_t/models/notification/notification.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../events/notification/retrieve_notification_nums/retrieve_notification_nums_event.dart';
import '../../events/notification/stream_user_notification/stream_user_notification_event.dart';
import '../../generated/abstract_bloc.dart';
import 'navigation_screen.dart';

class NavigationBloc extends AbstractBloc<NavigationScreenState>
    with StreamUserNotificationEvent, RetrieveNotificationNumsEvent {
  List<Notification> listNotification = [];
  int? countNotifications = 0;
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    sendRetrieveNotificationNumsEvent(currentUser);
    sendStreamUserNotificationEvent(currentUser.id);
    notifyDataChanged();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeStreamUserNotificationEvent();
  }

  @override
  void onStreamUserNotificationEventDone(List<Notification> userNotifications) {
    listNotification.addAll(userNotifications);
    sendRetrieveNotificationNumsEvent(currentUser);
    notifyDataChanged();
    // TODO: implement onStreamUserNotificationEventDone
  }

  @override
  void onRetrieveNotificationNumsEventDone(int countNotification) {
    countNotifications = countNotification;
    notifyDataChanged();
    // TODO: implement onRetrieveNotificationNumsEventDone
  }
}

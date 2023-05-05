import 'package:reel_t/models/notification/notification.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../events/notification/retrieve_notification_nums/retrieve_notification_nums_event.dart';
import '../../events/notification/stream_user_notification/stream_user_notification_event.dart';
import '../../generated/abstract_bloc.dart';
import 'navigation_screen.dart';

class NavigationBloc extends AbstractBloc<NavigationScreenState>
    with RetrieveNotificationNumsEvent {
  List<Notification> listNotification = [];
  int? countNotifications = 0;
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    sendRetrieveNotificationNumsEvent(currentUser);
    notifyDataChanged();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onRetrieveNotificationNumsEventDone(int countNotification) {
    countNotifications = countNotification;
    notifyDataChanged();
    // TODO: implement onRetrieveNotificationNumsEventDone
  }
}

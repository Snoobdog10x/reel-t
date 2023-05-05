import 'package:reel_t/models/notification/notification.dart';

import '../../events/notification/stream_user_notification/stream_user_notification_event.dart';
import '../../generated/abstract_bloc.dart';
import '../../models/user_profile/user_profile.dart';
import 'notification_screen.dart';

class NotificationBloc extends AbstractBloc<NotificationScreenState> {
  late UserProfile currentUser;

  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

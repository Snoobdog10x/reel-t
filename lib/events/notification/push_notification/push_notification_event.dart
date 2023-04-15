import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/notification/notification.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

abstract class PushNotificationEvent {
  Future<void> sendPushNotificationEvent({
    String userId = "",
    String notificationContent = "",
    NotificationType type = NotificationType.NEW_MESSAGE,
  }) async {
    try {
      var notification =
          await _createNotification(userId, notificationContent, type);
      onPushNotificationEventDone(notification);
    } catch (e) {
      print(e);
      onPushNotificationEventDone(null);
    }
  }

  Future<Notification> _createNotification(
    String userId,
    String notificationContent,
    NotificationType type,
  ) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Notification.PATH);

    var newDoc = db.doc();
    var newNotification = Notification(
      id: newDoc.id,
      userId: userId,
      notificationContent: notificationContent,
      notificationType: type.name,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
      hasSeen: false,
    );

    await newDoc.set(newNotification.toJson());
    return newNotification;
  }

  void onPushNotificationEventDone(Notification? notification);
}

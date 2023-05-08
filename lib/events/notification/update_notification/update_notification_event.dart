import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/notification/notification.dart';

abstract class UpdateNotificationEvent {
  Future<void> sendUpdateNotificationEvent(Notification newNotification) async {
    try {
      await _updateNotification(newNotification);
      onUpdateNotificationEventDone(newNotification);
    } catch (e) {
      print("UpdateNotificationEvent $e");
      onUpdateNotificationEventDone(newNotification);
    }
  }

  Future<void> _updateNotification(Notification newNotification) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(newNotification.userId)
        .collection(Notification.PATH)
        .doc(newNotification.id);

    return await db.set(newNotification.toJson());
  }

  void onUpdateNotificationEventDone(Notification updatedNotification);
}

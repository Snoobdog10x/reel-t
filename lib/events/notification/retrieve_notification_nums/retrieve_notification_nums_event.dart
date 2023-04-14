import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/notification/notification.dart';
import '../../../models/user_profile/user_profile.dart';

abstract class RetrieveNotificationNumsEvent {
  void sendRetrieveNotificationNumsEvent() {
    try {
      onRetrieveNotificationNumsEventDone(null);
    } catch (e) {
      onRetrieveNotificationNumsEventDone(e);
    }
  }

  Future<int> _getCountNotification(String userId) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Notification.PATH)
        .where(Notification.hasPushed_PATH, isEqualTo: false);
    return (await db.count().get()).count;
  }

  void onRetrieveNotificationNumsEventDone(dynamic e);
}

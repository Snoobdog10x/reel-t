import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/notification/notification.dart';
import '../../../models/user_profile/user_profile.dart';

abstract class RetrieveNotificationNumsEvent {
  late int countNotification;
  Future<void> sendRetrieveNotificationNumsEvent(
      UserProfile currentUser) async {
    try {
      countNotification = await _getCountNotification(currentUser.id);
      onRetrieveNotificationNumsEventDone(countNotification);
    } catch (e) {
      print("RetrieveNotificationNumsEvent $e");
      onRetrieveNotificationNumsEventDone(0);
    }
  }

  Future<int> _getCountNotification(String userId) async {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Notification.PATH)
        .where(Notification.hasSeen_PATH, isEqualTo: false);
    return (await db.count().get()).count;
  }

  void onRetrieveNotificationNumsEventDone(int countNotification);
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/notification/notification.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class StreamUserNotificationEvent {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _streamSubscription;
  void sendStreamUserNotificationEvent(String userId) {
    disposeStreamUserNotificationEvent();
    try {
      _streamSubscription = _getStreamUserNotification(userId);
    } catch (e) {
      print(e);
      onStreamUserNotificationEventDone([]);
    }
  }

  void disposeStreamUserNotificationEvent() {
    _streamSubscription?.cancel();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _getStreamUserNotification(String userId) {
    final db = FirebaseFirestore.instance
        .collection(UserProfile.PATH)
        .doc(userId)
        .collection(Notification.PATH);
    return db
        .orderBy(Notification.createAt_PATH, descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      var docs = event.docChanges;
      List<Notification> userNotifications = [];
      docs.forEach((doc) {
        var data = doc.doc.data();

        if (doc.type == DocumentChangeType.added) {
          if (data != null) userNotifications.add(Notification.fromJson(data));
        }
      });
      onStreamUserNotificationEventDone(userNotifications);
    });
  }

  void onStreamUserNotificationEventDone(List<Notification> userNotifications);
}

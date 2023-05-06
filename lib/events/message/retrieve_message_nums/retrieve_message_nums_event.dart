import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../models/conversation/conversation.dart';

abstract class RetrieveMessageNumsEvent {
  late int countMessage;
  Future<void> sendRetrieveMessageNumsEvent(UserProfile currentUser) async {
    try {
      countMessage = await _getCountMessage(currentUser.id);
      onRetrieveMessageNumsEventDone(countMessage);
    } catch (e) {
      print(e);
      onRetrieveMessageNumsEventDone(0);
    }
  }

  Future<int> _getCountMessage(String userId) async {
    final db = FirebaseFirestore.instance
        .collection(Conversation.PATH)
        .where(Conversation.userIds_PATH, arrayContains: userId);
    return (await db.count().get()).count;
  }

  void onRetrieveMessageNumsEventDone(int countMessage);
}

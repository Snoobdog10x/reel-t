import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/generated/app_store.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../../generated/abstract_bloc.dart';

abstract class CheckUsernameExistsEvent {
  Future<void> sendCheckUsernameExistsEvent(
      String userName, String currentUserName) async {
    try {
      // var db = FirebaseFirestore.instance.collection(UserProfile.PATH);
      // var snapshot =
      //     await db.where(UserProfile.userName_PATH, isEqualTo: userName).get();

      var isExists = await getCurrentUser(userName, currentUserName);
      onCheckUsernameExistsEventDone(isExists);
    } catch (e) {
      print(e);
      onCheckUsernameExistsEventDone(true);
    }
  }

  Future<bool> getCurrentUser(String userName, String currentUserName) async {
    var db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    var snapshot =
        await db.where(UserProfile.userName_PATH, isEqualTo: userName).get();
    var docs = snapshot.docs;
    print(userName + " " + currentUserName);
    if (docs.isEmpty) return false;
    var user = UserProfile.fromJson(docs.first.data());
    if (user.userName == currentUserName) return false;
    return true;
  }

  void onCheckUsernameExistsEventDone(bool isExists);
}

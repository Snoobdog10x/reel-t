import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class UpdateUserProfileEvent {
  void sendUpdateUserProfileEvent(UserProfile newUserProfile) {
    try {
      _updateUserProfile(newUserProfile);
      onUpdateUserProfileEventDone(newUserProfile);
    } catch (e) {
      print("UpdateUserProfileEvent $e");
      onUpdateUserProfileEventDone(null);
    }
  }

  Future<UserProfile> _updateUserProfile(UserProfile newUserProfile) async {
    var db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    await db.doc(newUserProfile.id).set(newUserProfile.toJson());
    return newUserProfile;
  }

  void onUpdateUserProfileEventDone(UserProfile? newUserProfile);
}

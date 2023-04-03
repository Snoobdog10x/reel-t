import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../events/user/user_sign_up/user_sign_up_event.dart';
import '../../../models/user_profile/user_profile.dart';

abstract class UserSignInEvent {
  Future<void> sendUserSignInEvent(String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final db = FirebaseFirestore.instance;
      var snapshot =
          await db.collection(UserProfile.PATH).doc(credential.user!.uid).get();
      var userProfile = UserProfile.fromJson(snapshot.data()!);
      onUserSignInEventDone("", userProfile);
    } on FirebaseAuthException catch (e) {
      var errorMessage = UserSignUpEvent.getMessageFromErrorCode(e);
      onUserSignInEventDone(errorMessage, null);
    }
  }

  void onUserSignInEventDone(
    String e,
    UserProfile? signedInUserProfile,
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../shared_product/utils/format/format_utlity.dart';

abstract class GoogleSignUpEvent {
  Future<void> sendGoogleSignUpEvent() async {
    try {
      final GoogleSignIn googleUser = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      var googleUserSignIn = await googleUser.signIn();
      if (googleUserSignIn == null) {
        onGoogleSignUpEventDone("");
        return;
      }

      var user = await _getUserProfileByEmail(googleUserSignIn.email);
      if (user == null) {
        onGoogleSignUpEventDoneWithSignUP(googleUserSignIn);
        return;
      }

      if (user.signUpType == SignUpType.EMAIL.index) {
        onGoogleSignUpEventDoneWithExistsUserEmail(
          "This email has been registered, use another account or link its to this google",
          googleUserSignIn,
        );
        return;
      }

      var userCredential = await signInUser(googleUserSignIn);
      onGoogleSignUpEventDoneWithSignIn("login", user);
    } catch (e, stacktrace) {
      print("GoogleSignUpEvent $e");
      print(stacktrace);
      onGoogleSignUpEventDone(e.toString());
    }
  }

  Future<UserProfile?> _getUserProfileByEmail(String email) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    var snapshot =
        await db.where(UserProfile.email_PATH, isEqualTo: email).get();
    if (snapshot.docs.isEmpty) return null;

    return UserProfile.fromJson(snapshot.docs.first.data());
  }

  Future<UserCredential> signInUser(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void onGoogleSignUpEventDoneWithSignIn(String e, UserProfile userProfile);
  void onGoogleSignUpEventDone(String e);
  void onGoogleSignUpEventDoneWithSignUP(
      GoogleSignInAccount googleSignInAccount);

  void onGoogleSignUpEventDoneWithExistsUserEmail(
      String e, GoogleSignInAccount googleSignInAccount);
}

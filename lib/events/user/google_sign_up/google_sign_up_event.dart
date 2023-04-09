import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class GoogleSignUpEvent {
  Future<void> sendGoogleSignUpEvent() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onGoogleSignUpEventDone("", null);
        return;
      }
      if (await isUserExists(googleUser.email)) {
        onGoogleSignUpEventDone(
            "This email has been signed up, please login or use another email",
            null);
        return;
      }
      var userCredential = await signInUser(googleUser);
      var signedUser = await createUserProfile(userCredential);
      onGoogleSignUpEventDone("success", signedUser);
    } catch (e) {
      onGoogleSignUpEventDone(e.toString(), null);
    }
  }

  Future<bool> isUserExists(String email) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    var snapshot =
        await db.where(UserProfile.email_PATH, isEqualTo: email).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<UserCredential> signInUser(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserProfile?> createUserProfile(UserCredential userCredential) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    var user = userCredential.user;
    if (user == null) return null;

    var id = user.uid;
    var tempName = user.email!.split("@")[0];
    UserProfile userProfile = UserProfile(
      id: id,
      email: user.email,
      fullName: tempName,
      userName: "@$tempName",
    );
    await db.doc().set(userProfile.toJson());
    return userProfile;
  }

  void onGoogleSignUpEventDone(String e, UserProfile? signedUser);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel_t/events/setting/create_user_setting/create_user_setting_event.dart';
import 'package:reel_t/models/setting/setting.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

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
        onGoogleSignUpEventDone("", null);
        return;
      }

      var userCredential = await signInUser(googleUserSignIn);
      var signedUser = await _createUserProfile(userCredential);
      onGoogleSignUpEventDone("success", signedUser);
    } catch (e) {
      print(e);
      onGoogleSignUpEventDone(e.toString(), null);
    }
  }

  Future<bool> isUserExists(String email) async {
    var userProfile = await _getUserProfileByEmail(email);
    return userProfile != null;
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
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserProfile?> _createUserProfile(UserCredential userCredential) async {
    final db = FirebaseFirestore.instance.collection(UserProfile.PATH);
    var user = userCredential.user;
    if (user == null) return null;
    var userProfile = await _getUserProfileByEmail(userCredential.user!.email!);
    if (userProfile != null) return userProfile;

    var id = user.uid;
    var tempName = user.email!.split("@")[0];
    UserProfile newUserProfile = UserProfile(
      id: id,
      email: user.email,
      fullName: tempName,
      userName: "@$tempName",
      isSignUpByGoogle: true,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    await db.doc(id).set(newUserProfile.toJson());
    return newUserProfile;
  }

  void onGoogleSignUpEventDone(String e, UserProfile? signedUser);
}

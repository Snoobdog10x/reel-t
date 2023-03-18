import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class UserSignUpEvent {
  void sendUserSignUpEventEvent(
    UserProfile userProfile,
    String password,
  ) async {
    try {
      final db = FirebaseFirestore.instance;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userProfile.email ?? "",
        password: password,
      );
      db
          .collection("UserProfiles")
          .doc(credential.user!.uid.toString())
          .set(userProfile.toJson());
      onUserSignUpEventDone("");
    } on FirebaseAuthException catch (e) {
      var errorMessage = getMessageFromErrorCode(e);
      onUserSignUpEventDone(errorMessage);
    }
  }

  void onUserSignUpEventDone(String errorMessage);

  static String getMessageFromErrorCode(FirebaseAuthException error) {
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }
}

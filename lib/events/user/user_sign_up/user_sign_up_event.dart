import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/events/user/google_sign_up/google_sign_up_event.dart';
import '../../../models/user_profile/user_profile.dart';

abstract class UserSignUpEvent {
  void sendUserSignUpEvent({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await createUserCredential(email, password);
      var userProfile = await GoogleSignUpEvent.createUserProfile(credential);
      onUserSignUpEventDone("", userProfile);
    } on FirebaseAuthException catch (e) {
      var errorMessage = getMessageFromErrorCode(e);
      onUserSignUpEventDone(errorMessage, null);
    }
  }

  Future<UserCredential> createUserCredential(
      String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void onUserSignUpEventDone(
      String errorMessage, UserProfile? signedUserProfile);

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

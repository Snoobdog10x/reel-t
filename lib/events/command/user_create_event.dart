import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

abstract class UserCreateEvent {
  Future<void> sendUserCreateEvent(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserProfile createdUser = UserProfile();
      createdUser.mergeFromFirebase(credential.user);
      onUserCreatedEvent(createdUser, null);
    } on FirebaseAuthException catch (e) {
      onUserCreatedEvent(null, e);
    } catch (e) {
      print(e);
    }
  }

  void onUserCreatedEvent(
    UserProfile? userProfile,
    FirebaseException? firebaseException,
  );
}

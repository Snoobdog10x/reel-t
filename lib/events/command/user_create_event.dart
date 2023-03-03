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
      onUserCreatedEvent(null);
    } on FirebaseAuthException catch (e) {
      onUserCreatedEvent(e);
    } catch (e) {
      print(e);
    }
  }

  void onUserCreatedEvent(
    FirebaseException? firebaseException,
  );
}

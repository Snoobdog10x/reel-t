import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/events/user/user_sign_up/user_sign_up_event.dart';

abstract class UpdatePasswordEvent {
  Future<void> sendUpdatePasswordEvent(String newPassword) async {
    try {
      final auth = FirebaseAuth.instance;
      if (auth.currentUser == null)
        return onUpdatePasswordEventDone("user is not login");
      await auth.currentUser!.updatePassword(newPassword);

      onUpdatePasswordEventDone("");
    } on FirebaseAuthException catch (e) {
      print("sendUpdatePasswordEvent $e");
      var message = UserSignUpEvent.getMessageFromErrorCode(e);
      onUpdatePasswordEventDone(message);
    }
  }

  void onUpdatePasswordEventDone(String e);
}

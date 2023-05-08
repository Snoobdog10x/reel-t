import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LinkCredentialEvent {
  Future<void> sendLinkCredentialEvent(
      GoogleSignInAccount googleSignInAccount) async {
    try {
      var authentication = await googleSignInAccount.authentication;
      var credential =
          GoogleAuthProvider.credential(idToken: authentication.idToken);
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        onLinkCredentialEventDone("Not found user, please link again");
        return;
      }

      var auth = currentUser.linkWithCredential(credential);
      onLinkCredentialEventDone("");
    } catch (e) {
      print("LinkCredentialEvent $e");
      onLinkCredentialEventDone(e.toString());
    }
  }

  void onLinkCredentialEventDone(String e);
}


abstract class UserSignInEvent {
  void sendUserSignInEventEvent() {
    try {
      onUserSignInEventDone(null);
    } catch (e) {
      onUserSignInEventDone(e);
    }
  }

  void onUserSignInEventDone(dynamic e);
}
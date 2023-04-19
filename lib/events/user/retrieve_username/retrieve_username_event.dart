abstract class RetrieveUsernameEvent {
  void sendRetrieveUsernameEvent() {
    try {
      onRetrieveUsernameEventDone(null);
    } catch (e) {
      onRetrieveUsernameEventDone(e);
    }
  }

  void onRetrieveUsernameEventDone(dynamic e);
}


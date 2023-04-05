abstract class VerifyUserEmailEvent {
  void sendVerifyUserEmailEventEvent() {
    try {
      onVerifyUserEmailEventDone(null);
    } catch (e) {
      onVerifyUserEmailEventDone(e);
    }
  }

  void onVerifyUserEmailEventDone(dynamic e);
}


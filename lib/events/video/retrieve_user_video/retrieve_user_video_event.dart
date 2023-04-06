abstract class RetrieveUserVideoEvent {
  void sendRetrieveUserVideoEvent() {
    try {
      onRetrieveUserVideoEventDone(null);
    } catch (e) {
      onRetrieveUserVideoEventDone(e);
    }
  }

  void onRetrieveUserVideoEventDone(dynamic e);
}


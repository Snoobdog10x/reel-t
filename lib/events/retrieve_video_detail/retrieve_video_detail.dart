
abstract class RetrieveVideoDetailEvent {
  void sendRetrieveVideoDetailEvent() {
    try {
      onRetrieveVideoDetailEventDone(null);
    } catch (e) {
      onRetrieveVideoDetailEventDone(e);
    }
  }

  void onRetrieveVideoDetailEventDone(dynamic e);
}
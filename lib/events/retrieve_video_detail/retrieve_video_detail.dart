
abstract class RetrieveVideoDetailEvent {
  void sendRetrieveVideoDetailEventEvent() {
    try {
      onRetrieveVideoDetailEventDone(null);
    } catch (e) {
      onRetrieveVideoDetailEventDone(e);
    }
  }

  void onRetrieveVideoDetailEventDone(dynamic e);
}
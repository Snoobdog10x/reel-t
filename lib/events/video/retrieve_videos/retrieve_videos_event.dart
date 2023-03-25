abstract class RetrieveVideosEvent {
  void sendRetrieveVideosEventEvent() {
    try {
      onRetrieveVideosEventDone(null);
    } catch (e) {
      onRetrieveVideosEventDone(e);
    }
  }

  void onRetrieveVideosEventDone(dynamic e);
}


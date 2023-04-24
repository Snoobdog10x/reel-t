abstract class StreamCommentEvent {
  void sendStreamCommentEvent() {
    try {
      onStreamCommentEventDone(null);
    } catch (e) {
      onStreamCommentEventDone(e);
    }
  }

  void onStreamCommentEventDone(dynamic e);
}


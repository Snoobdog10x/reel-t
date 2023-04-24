abstract class SendCommentEvent {
  void sendSendCommentEvent() {
    try {
      onSendCommentEventDone(null);
    } catch (e) {
      onSendCommentEventDone(e);
    }
  }

  void onSendCommentEventDone(dynamic e);
}


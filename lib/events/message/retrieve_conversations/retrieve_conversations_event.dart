abstract class RetrieveConversationsEvent {
  void sendRetrieveConversationsEventEvent() {
    try {
      onRetrieveConversationsEventDone(null);
    } catch (e) {
      onRetrieveConversationsEventDone(e);
    }
  }

  void onRetrieveConversationsEventDone(dynamic e);
}


abstract class RetrieveConversationsEvent {
  void sendRetrieveConversationsEvent() {
    try {
      onRetrieveConversationsEventDone(null);
    } catch (e) {
      onRetrieveConversationsEventDone(e);
    }
  }

  void onRetrieveConversationsEventDone(dynamic e);
}


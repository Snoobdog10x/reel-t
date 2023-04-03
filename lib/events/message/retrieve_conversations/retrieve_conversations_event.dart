abstract class RetrieveConversationsEvent {
  void sendRetrieveConversationsEventEvent() {
    try {
      onRetrieveConversationsEventDone(null);
    } catch (e) {
      onRetrieveConversationsEventDone(e);
    }
  }

  void onRetrieveConversationsEventDone(dynamic e);

  // Future<Like> _retrieveLike(String videoId, String currentUserId) async {
  //   var snapshot = await db
  //       .collection(Video.PATH)
  //       .doc(videoId)
  //       .collection(Like.PATH)
  //       .where("userId", isEqualTo: currentUserId)
  //       .get();
  //   var docs = snapshot.docs;
  //   if (docs.isEmpty) {
  //     return Like(videoId: videoId, userId: currentUserId);
  //   }
  //   return Like.fromJson(docs.first.data());
  // }
}


abstract class UploadVideoEvent {
  void sendUploadVideoEvent() {
    try {
      onUploadVideoEventDone(null);
    } catch (e) {
      onUploadVideoEventDone(e);
    }
  }

  void onUploadVideoEventDone(dynamic e);
}


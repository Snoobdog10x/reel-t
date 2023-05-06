import 'dart:async';

abstract class MediaInteractionInterface {
  Timer? rollBackTimer;
  bool isLockInteractive = false;
  final int INTERACT_TIME_OUT = 1000;
  void changeInteractionState();
  
  void interactMedia(void Function() notifyDataChanged);

  bool isLockInteractMedia() => isLockInteractive;

  void lockInteractMedia() {
    if (isLockInteractive) return;

    isLockInteractive = true;
  }

  void unlockInteractMedia() {
    if (!isLockInteractive) return;

    isLockInteractive = false;
  }

  void cancelRollBack() {
    rollBackTimer?.cancel();
    rollBackTimer = null;
  }
}

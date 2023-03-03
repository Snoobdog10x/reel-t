import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:reel_t/events/command_event/user_create_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';

class SampleProvider extends AbstractProvider with UserCreateEvent {
  String email = "";
  String password = "";

  @override
  Future<void> sendUserCreateEvent(String email, String password) {
    // TODO: implement sendUserCreateEvent
    return super.sendUserCreateEvent(email, password);
  }

  @override
  void onUserCreatedEvent(FirebaseException? firebaseException) {
    if (firebaseException != null) {
      print(firebaseException.message.toString());
      notifyDataChanged();
      return;
    }
    print("created");
    notifyDataChanged();
  }
}

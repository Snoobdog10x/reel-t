import '../../../generated/abstract_provider.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';

class ProfileProvider extends AbstractProvider {
  late Conversation conversation;
  late UserProfile currentUser;
  late UserProfile contactUser;
  void init(Conversation conversation) {
    this.conversation = conversation;
    currentUser = appStore.localUser.getCurrentUser();
    contactUser = conversation.secondUser.first;
  }
}

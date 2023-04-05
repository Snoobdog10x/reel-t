import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';

class ProfileBloc extends AbstractBloc {
  late Conversation conversation;
  late UserProfile currentUser;
  late UserProfile contactUser;
  void init(Conversation conversation) {
    this.conversation = conversation;
    currentUser = appStore.localUser.getCurrentUser();
    contactUser = conversation.secondUser.first;
  }
}

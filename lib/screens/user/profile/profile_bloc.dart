import 'package:reel_t/screens/user/profile/profile_screen.dart';

import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';

class ProfileBloc extends AbstractBloc<ProfileScreenState> {
  late Conversation conversation;
  late UserProfile currentUser;
  late UserProfile contactUser;
  void init(Conversation conversation) {
    this.conversation = conversation;
    currentUser = appStore.localUser.getCurrentUser();
    contactUser = conversation.secondUser.first;
  }
}

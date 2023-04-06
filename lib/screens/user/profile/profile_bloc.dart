import 'package:reel_t/screens/user/profile/profile_screen.dart';

import '../../../events/message/retrieve_conversations/retrieve_conversations_event.dart';
import '../../../events/user/retrieve_user_profile/retrieve_user_profile_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ProfileBloc extends AbstractBloc<ProfileScreenState>
    with RetrieveConversationsEvent, RetrieveUserProfileEvent {
  Map<String, Conversation> conversations = new Map<String, Conversation>();
  List<Video> userVideos = [];
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    if (currentUser.id.isEmpty) return;

    sendRetrieveConversationsEvent(currentUser);
    notifyDataChanged();
  }

  @override
  void onRetrieveConversationsEventDone(
      e, List<Conversation> updatedConversations) {
    if (e == null) {
      for (var conversation in updatedConversations) {
        if (!_isContainConversation(conversation)) {
          this.conversations[conversation.id] = conversation;
          var secondUserId = conversation.userIds
              .firstWhere((element) => element != currentUser.id);
          sendRetrieveUserProfileEvent(secondUserId, conversation.id);
        }
      }
    }
  }

  bool _isContainConversation(Conversation conversation) {
    return conversations[conversation.id] != null;
  }

  @override
  void onRetrieveUserProfileEventDone(e, UserProfile? userProfile,
      [String? conversationId]) {
    if (e == null) {
      conversations[conversationId]!.secondUser.add(userProfile!);
    }
    notifyDataChanged();
  }

}

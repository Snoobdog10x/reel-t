import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_provider.dart';

class HomeChatProvider extends AbstractProvider {
  String USER_KEY = "user";
  String CONVERSATION_KEY = "conversation";
  Map<String, Map<String, dynamic>> conversations = {};
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  void init() {
    for (int i = 0; i < 10; i++) {
      conversations[i.toString()] = {
        USER_KEY: UserProfile(
            id: i.toString(), fullName: "Nguyen Duy Thanh", avatar: avatar),
        CONVERSATION_KEY: Conversation(
          id: i.toString(),
          secondUserId: i.toString(),
        )
      };
    }
    notifyDataChanged();
  }
}

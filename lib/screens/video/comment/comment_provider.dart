import 'dart:math';

import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_provider.dart';
import '../../../models/comment/comment.dart';

class CommentProvider extends AbstractProvider {
  String mockAvatar =
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842";
  List<Comment> comments = [];
  void init() {
    List<String> contents = [
      "bạn xinh quá!",
      "wow trông thật cute",
      "hihi",
      "mãi keo"
    ];
    for (int i = 0; i < 10; i++) {
      var id = i.toString();
      var comment = Comment(
        id: id,
        userId: id,
        user: [
          UserProfile(
            id: id,
            userName: "Thanh",
            avatar: mockAvatar,
          ),
        ],
        content: contents[Random().nextInt(contents.length)],
      );
      comments.add(comment);
    }
    comments[0].subComments.addAll(comments.getRange(0, 3));
    comments[2].subComments.addAll(comments.getRange(3, 6));
  }
}

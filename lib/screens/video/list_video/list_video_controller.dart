import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ListVideoController {
  final List<Video> _videos = [];
  final Map<String, UserProfile> _creators = {};
  final Map<String, Like> _like = {};
  final Map<String, Follow> _follow = {};
}

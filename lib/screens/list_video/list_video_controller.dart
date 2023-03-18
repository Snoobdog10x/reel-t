import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/models/video/video.dart';

class ListVideoController {
  final List<Video> _videos = [];
  final Map<String, UserProfile> _creators = {};
  final Map<String, Like> _like = {};
  final Map<String, Follow> _follow = {};
}

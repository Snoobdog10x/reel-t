import 'package:intl/intl.dart';

import '../../../generated/abstract_provider.dart';
import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';

class ListVideoProvider extends AbstractProvider {
  final Map<String, UserProfile> creators = {};
  final Map<String, Follow> follow = {};
  int currentPage = 0;
  String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }
}

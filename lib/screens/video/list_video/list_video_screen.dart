import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import 'list_video_provider.dart';

import '../../../shared_product/widgets/video_player_item.dart';

class ListVideoScreen extends StatefulWidget {
  final List<Video> videos;
  final Function loadMoreVideos;
  ListVideoScreen({
    super.key,
    required this.videos,
    required this.loadMoreVideos,
  });

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends AbstractState<ListVideoScreen>
    with AutomaticKeepAliveClientMixin {
  late ListVideoProvider provider;
  int currentIndex = 0;
  @override
  AbstractProvider initProvider() {
    return provider;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    provider = ListVideoProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<ListVideoProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              isSafe: false,
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return VisibilityDetector(
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction <= 0.5) {
          widget.videos[currentIndex].changeVideoState();
        }
      },
      key: ObjectKey(this),
      child: PreloadPageView.builder(
        scrollDirection: Axis.vertical,
        preloadPagesCount: 4,
        itemCount: widget.videos.length,
        onPageChanged: (index) {
          widget.videos[currentIndex].changeVideoState();
          currentIndex = index;
          widget.videos[currentIndex].changeVideoState();
          notifyDataChanged();
          if (index >= widget.videos.length - 4) {
            widget.loadMoreVideos();
          }
        },
        itemBuilder: (context, index) {
          var video = widget.videos[index];
          return VideoPlayerItem(
            video: video,
            isPlay: index == currentIndex,
          );
        },
      ),
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/video/video_detail.dart';
import 'package:reel_t/shared_product/widgets/tiktok/actions_toolbar.dart';
import 'package:reel_t/shared_product/widgets/tiktok/video_description.dart';
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
  final List<VideoDetail> videos;
  final Function loadMoreVideos;
  ListVideoScreen({
    super.key,
    this.videos = const [],
    required this.loadMoreVideos,
  });

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends AbstractState<ListVideoScreen>
    with AutomaticKeepAliveClientMixin {
  late ListVideoProvider provider;
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
    provider.init(widget.videos);
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<ListVideoProvider>(
          builder: (context, value, child) {
            if (widget.videos.isEmpty) {
              return buildLoadWidget();
            }
            var body = buildBody();
            return buildScreen(
              isSafe: false,
              body: body,
              background: Colors.black,
            );
          },
        );
      },
    );
  }

  Widget buildPreloadPageVideo() {
    return PreloadPageView.builder(
      scrollDirection: Axis.vertical,
      preloadPagesCount: 4,
      itemCount: widget.videos.length,
      onPageChanged: (index) {
        if (index >= widget.videos.length - 4) {
          widget.loadMoreVideos();
        }
      },
      itemBuilder: (context, index) {
        var videoDetail = widget.videos[index];
        var video = videoDetail.video;
        if (!videoDetail.isLoadDetail()) {
          provider.sendRetrieveVideoDetailEventEvent(
            videoId: video.id,
            currentUserId: provider.currentUser.id,
            creatorId: video.creatorId,
            index: index,
          );
          return buildLoadWidget();
        }
        return Stack(
          children: [
            buildVideoPlayer(videoDetail, index),
            buildDescription(videoDetail),
            buildActionBar(videoDetail),
          ],
        );
      },
    );
  }

  Widget buildLoadWidget() {
    return Container(
      color: Colors.black,
      child: CupertinoActivityIndicator(
        radius: 20,
        color: Colors.white,
      ),
    );
  }

  Widget buildVideoPlayer(VideoDetail videoDetail, int index) {
    return Container(
      height: screenHeight(),
      width: screenWidth(),
      child: VideoPlayerItem(
        video: videoDetail.video,
        isPlay: index == provider.currentPage,
      ),
    );
  }

  Widget buildDescription(VideoDetail videoDetail) {
    var video = videoDetail.video;
    return Container(
      alignment: Alignment.bottomLeft,
      child: VideoDescription(
        username: videoDetail.creator!.userName,
        videtoTitle: video.title,
        songInfo: video.songName,
      ),
    );
  }

  Widget buildActionBar(VideoDetail videoDetail) {
    var video = videoDetail.video;
    return Container(
      alignment: Alignment.bottomRight,
      child: ActionsToolbar(
        numLikes: provider.formatNumber(video.likesNum),
        numComments: provider.formatNumber(video.commentsNum),
        isLiked: videoDetail.like!.likeType == LikeType.LIKE.index,
        userPic: videoDetail.creator!.avatar,
        onTapLike: () {
          videoDetail.likeVideo();
          notifyDataChanged();
          
          // provider.sendLikeVideoEventEvent(videoDetail.like!);
        },
      ),
    );
  }

  Widget buildBody() {
    if (widget.videos.isEmpty) {
      return Container(
        color: Colors.black,
      );
    }
    return buildPreloadPageVideo();
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/video/comment/comment_screen.dart';
import 'package:reel_t/shared_product/widgets/tiktok/actions_toolbar.dart';
import 'package:reel_t/shared_product/widgets/tiktok/video_description.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../models/follow/follow.dart';
import '../../../models/like/like.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/utils/format/format_utlity.dart';
import 'list_video_bloc.dart';

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
  State<ListVideoScreen> createState() => ListVideoScreenState();
}

class ListVideoScreenState extends AbstractState<ListVideoScreen>
    with AutomaticKeepAliveClientMixin {
  late ListVideoBloc bloc;
  @override
  AbstractBloc initBloc() {
    return bloc;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    bloc = ListVideoBloc();
    bloc.init(widget.videos);
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<ListVideoBloc>(
          builder: (context, value, child) {
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
        var video = bloc.videos[index];
        if (!bloc.isLoadVideoDetail(video)) {
          bloc.loadVideoDetail(video);
          return buildLoadWidget();
        }
        return Stack(
          children: [
            buildVideoPlayer(video, index),
            buildDescription(video),
            buildActionBar(video),
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

  Widget buildVideoPlayer(Video video, int index) {
    return Container(
      height: screenHeight(),
      width: screenWidth(),
      child: VideoPlayerItem(
        videoUrl: video.videoUrl,
        isPlay: index == bloc.currentPage,
      ),
    );
  }

  Widget buildDescription(Video video) {
    var creator = bloc.creators[video.id];
    return Container(
      alignment: Alignment.bottomLeft,
      child: VideoDescription(
        username: creator!.userName,
        videtoTitle: video.title,
        songInfo: video.songName,
      ),
    );
  }

  Widget buildActionBar(Video video) {
    var creator = bloc.creators[video.id];
    return Container(
      alignment: Alignment.bottomRight,
      child: ActionsToolbar(
        numLikes: video.likesNum,
        numComments: video.commentsNum,
        isLiked: bloc.isLikeVideo(video),
        isFollow: bloc.isFollowCreator(video),
        userPic: creator!.avatar,
        onTapLike: (isActive) async {
          await bloc.likeVideo(video);
          return true;
        },
        onTapFollow: (isActive) async {
          await bloc.followUser(video);
          return true;
        },
        onTapComment: (isActive) async {
          showScreenBottomSheet(
            Container(
              height: screenHeight() * 0.6,
              child: CommentScreen(
                commentsNum: video.commentsNum,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody() {
    if (widget.videos.isEmpty) {
      return buildLoadWidget();
    }
    return buildPreloadPageVideo();
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

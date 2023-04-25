import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';
import 'package:reel_t/screens/video/comment/comment_screen.dart';
import 'package:reel_t/shared_product/widgets/tiktok/actions_toolbar.dart';
import 'package:reel_t/shared_product/widgets/tiktok/video_description.dart';
import '../../../models/video/video.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'list_video_bloc.dart';

import '../../../shared_product/widgets/video_player_item.dart';

class ListVideoScreen extends StatefulWidget {
  final List<Video> videos;
  final Function loadMoreVideos;
  final int startAtIndex;
  final bool isShowBack;
  ListVideoScreen({
    super.key,
    required this.videos,
    required this.loadMoreVideos,
    this.startAtIndex = 0,
    this.isShowBack = false,
  });

  @override
  State<ListVideoScreen> createState() => ListVideoScreenState();
}

class ListVideoScreenState extends AbstractState<ListVideoScreen>
    with AutomaticKeepAliveClientMixin {
  late ListVideoBloc bloc;
  late PreloadPageController _controller;
  Widget? bottomSheet;
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
    _controller = PreloadPageController(initialPage: widget.startAtIndex);
    bloc.init(widget.videos);
  }

  @override
  void onReady() {}

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
      controller: _controller,
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
        var isLoadUser = bloc.isLoadVideoDetail(video);
        if (!isLoadUser) {
          bloc.loadVideoDetail(video);
        }
        return Stack(
          children: [
            buildVideoPlayer(video, index),
            if (isLoadUser) ...[
              buildDescription(video),
              buildActionBar(video),
            ],
            if (!isLoadUser) ...[buildLoadWidget()]
          ],
        );
      },
    );
  }

  Widget buildLoadWidget() {
    return Container(
      color: Colors.black,
      height: screenHeight(),
      width: screenWidth(),
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
    var creator = bloc.creators[video.creatorId]!;
    return Container(
      alignment: Alignment.bottomLeft,
      child: VideoDescription(
        username: creator.userName,
        videtoTitle: video.title,
        songInfo: video.songName,
        onTapUserName: () {
          pushToScreen(ProfileScreen(
            user: creator,
            isBack: true,
            userFollow: bloc.followCreators[video.creatorId],
          ));
        },
      ),
    );
  }

  Widget buildActionBar(Video video) {
    var creator = bloc.creators[video.creatorId];
    return Container(
      alignment: Alignment.bottomRight,
      child: ActionsToolbar(
        numLikes: video.likesNum,
        numComments: video.commentsNum,
        isLiked: bloc.isLikeVideo(video),
        isFollow: bloc.isFollowCreator(video),
        userPic: creator!.avatar,
        onTapLike: (isActive) async {
          bloc.likeVideo(video);
          if (bloc.currentUser.id.isEmpty) return false;

          return true;
        },
        onTapFollow: (isActive) async {
          bloc.followUser(video);
          if (bloc.currentUser.id.isEmpty) return false;
          return true;
        },
        onTapAvatar: () {
          pushToScreen(ProfileScreen(
            user: creator,
            isBack: true,
            userFollow: bloc.followCreators[video.creatorId],
          ));
        },
        onTapComment: (isActive) async {
          if (bottomSheet == null)
            bottomSheet = Container(
              height: screenHeight() * 0.7,
              child: CommentScreen(
                video: video,
                commentsNum: video.commentsNum,
              ),
            );
          showScreenBottomSheet(bottomSheet!);
        },
      ),
    );
  }

  Widget buildBody() {
    if (widget.isShowBack) {
      return Stack(
        children: [buildPreloadPageVideo(), buildTapBack()],
      );
    }

    return buildPreloadPageVideo();
  }

  Widget buildTapBack() {
    return Container(
      margin: EdgeInsets.only(top: paddingTop(), left: 15),
      width: screenWidth(),
      alignment: Alignment.centerLeft,
      height: 50,
      child: GestureDetector(
        onTap: () {
          popTopDisplay();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

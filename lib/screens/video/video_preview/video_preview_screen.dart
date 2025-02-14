import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/navigation/navigation_screen.dart';
import 'package:reel_t/screens/video/create_post/create_post_screen.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import 'package:reel_t/shared_product/widgets/video_player_item.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'video_preview_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';


class VideoPreviewScreen extends StatefulWidget {
  final String filePath;
  const VideoPreviewScreen({super.key, required this.filePath});

  @override
  State<VideoPreviewScreen> createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends AbstractState<VideoPreviewScreen> {
  late VideoPreviewBloc bloc;

  late Widget videoPreview = VideoPlayerItem(
    videoUrl: widget.filePath,
    isPlay: false,
  );
  @override
  AbstractBloc initBloc() {
    return bloc;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  Future<void> onCreate() async {
    bloc = VideoPreviewBloc();
    bloc.init();
    print(widget.filePath);
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<VideoPreviewBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              background: Colors.black,
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Container(
      height: screenHeight(),
      width: screenWidth(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          videoPreview,
          buildConfirmVideo(),
        ],
      ),
    );
  }

  Widget buildConfirmVideo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: screenWidth(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: buildConfirmButton(
              Colors.white,
              "Your Feed",
              Colors.black,
              bloc.currentUser.avatar,
              () {
                bloc.createFeedPost(widget.filePath);
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: buildConfirmButton(
              Colors.red,
              "Next",
              Colors.white,
              null,
              () {
                pushToScreen(CreatePostScreen(
                  filePath: widget.filePath,
                  recoredVideo: videoPreview,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmButton(Color color, String text, Color textColor,
      String? avatar, Function()? onTap) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 50,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (avatar != null) ...[
              CircleImage(
                avatar,
                background: Colors.grey.shade300,
                radius: 30,
              ),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: SharedTextStyle.NORMAL_SIZE,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onPopWidget(String previousScreen) {
    // TODO: implement onPopWidget
    super.onPopWidget(previousScreen);
    pushToScreen(NavigationScreen(), isReplace: true);
  }

  @override
  Future<void> onDispose() async {}
}

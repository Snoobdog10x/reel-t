import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/models/like/like.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/list_video/list_video_provider.dart';

import '../../shared_product/widgets/video_player_item.dart';
import 'list_video_controller.dart';

class ListVideoScreen extends StatefulWidget {
  final ListVideoController controller;
  const ListVideoScreen({super.key, required this.controller});

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends AbstractState<ListVideoScreen>
    with AutomaticKeepAliveClientMixin {
  late ListVideoProvider provider;
  late ListVideoController controller = widget.controller;

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
    return PreloadPageView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return VideoPlayerItem();
      },
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


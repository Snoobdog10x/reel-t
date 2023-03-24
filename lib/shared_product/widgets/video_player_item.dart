import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/video/video.dart';

class VideoPlayerItem extends StatefulWidget {
  final Video video;
  const VideoPlayerItem({
    super.key,
    required this.video,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  @override
  void initState() {
    super.initState();
    widget.video.initController(notifyDataChanged);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.video.isInitialized()) {
      return Container(color: Colors.black);
    }
    return buildReadyVideo();
  }

  void notifyDataChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildReadyVideo() {
    var _controller = widget.video.getVideoController()!;
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller.value.aspectRatio,
        height: 1,
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.video.disposeController();
  }
}

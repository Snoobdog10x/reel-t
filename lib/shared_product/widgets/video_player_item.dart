import 'package:flutter/material.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({super.key});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() async {
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/reel-t.appspot.com/o/videos%2F02062023_video_Beauty_6.mp4?alt=media&token=57f64899-2b2a-4a1f-be24-3e6648a3d484');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    await _controller.initialize();
    // _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container(color: Colors.black);
    }
    return buildReadyVideo();
  }

  Widget buildReadyVideo() {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller.value.aspectRatio,
        height: 1,
        child: VideoPlayer(_controller),
      ),
    );
  }
}

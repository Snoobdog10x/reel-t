import 'dart:convert';

import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../generated/abstract_model.dart';
import '../../models/like/like.dart';
import 'package:video_player/video_player.dart';

enum PublicMode { PUBLIC, PRIVATE }

class Video extends AbstractModel {
  late String id;
  late String videoUrl;
  late String songName;
  late String creatorId;
  late String title;
  late int publicMode;
  late int commentsNum;
  late int likesNum;
  late int viewsNum;
  late bool isDeleted;
  static String PATH = "Videos";
  List<Like> likes = [];
  UserProfile? creator = UserProfile();
  Function? _notifyDataChanged;
  VideoPlayerController? _controller;
  Video({
    String? id,
    String? videoUrl,
    String? songName,
    String? creatorId,
    String? title,
    int? publicMode,
    int? commentsNum,
    int? likesNum,
    int? viewsNum,
    bool? isDeleted,
  }) {
    this.id = id ?? "";
    this.videoUrl = videoUrl ?? "";
    this.songName = songName ?? "";
    this.creatorId = creatorId ?? "";
    this.title = title ?? "";
    this.publicMode = publicMode ?? 0;
    this.commentsNum = commentsNum ?? 0;
    this.likesNum = likesNum ?? 0;
    this.viewsNum = viewsNum ?? 0;
    this.isDeleted = isDeleted ?? false;
  }
  void initController(bool isPlay, Function notifyDataChanged) async {
    if (_controller != null && _controller!.value.isInitialized) {
      return;
    }
    this._notifyDataChanged = notifyDataChanged;
    _controller = VideoPlayerController.network(videoUrl);
    _controller!.addListener(() {
      notifyDataChanged();
    });
    _controller!.setLooping(true);
    await _controller!.initialize();
    if (isPlay) {
      _controller!.play();
    }
  }

  void disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  bool isInitialized() {
    if (_controller != null && _controller!.value.isInitialized) {
      return true;
    }
    return false;
  }

  void changeVideoState() {
    if (_controller!.value.isPlaying) {
      stopVideo();
      return;
    }
    playVideo();
  }

  void playVideo() {
    _controller?.play();
  }

  void stopVideo() {
    _controller?.pause();
  }

  VideoPlayerController? getVideoController() {
    return _controller;
  }

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    videoUrl = json["videoUrl"];
    songName = json["songName"];
    creatorId = json["creatorId"];
    title = json["title"];
    publicMode = json["publicMode"];
    commentsNum = json["commentsNum"];
    likesNum = json["likesNum"];
    viewsNum = json["viewsNum"];
    isDeleted = json["isDeleted"];
  }

  Video.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Video.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  String toString() {
    return toStringJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["videoUrl"] = this.videoUrl;
    data["songName"] = this.songName;
    data["creatorId"] = this.creatorId;
    data["title"] = this.title;
    data["publicMode"] = this.publicMode;
    data["commentsNum"] = this.commentsNum;
    data["likesNum"] = this.likesNum;
    data["viewsNum"] = this.viewsNum;
    data["isDeleted"] = this.isDeleted;
    return data;
  }
}

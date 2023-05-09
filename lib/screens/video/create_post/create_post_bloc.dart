import 'package:image_picker/image_picker.dart';

import '../../../events/upload/upload_video/upload_video_event.dart';
import '../../../events/video/video_create/video_create_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../models/video/video.dart';
import '../../../shared_product/utils/editor/video_editor.dart';
import '../../../shared_product/utils/format/format_utlity.dart';
import '../list_video/list_video_screen.dart';
import 'create_post_screen.dart';

class CreatePostBloc extends AbstractBloc<CreatePostScreenState>
    with UploadVideoEvent, VideoCreateEvent {
  late UserProfile currentUser;
  VideoEditor videoEditor = VideoEditor();
  String thumbnail = "";
  Video video = Video();
  String title = "";
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
  }

  List<String> extractHashtags(String text) {
    Iterable<Match> matches = RegExp(r"\B(\#[a-zA-Z]+\b)").allMatches(text);
    var hashtags = matches
        .map((m) => m[0]?.replaceAll("#", ""))
        .toList()
        .whereType<String>()
        .toList();
    hashtags.add("trending");
    return hashtags;
  }

  Future<void> createFeedPost(String filePath) async {
    state.startLoading();
    XFile video = XFile(filePath);
    thumbnail = await videoEditor.encodeThumbnail(filePath);
    sendUploadVideoEvent(video,
        "${FormatUtility.getMillisecondsSinceEpoch()}_${currentUser.id}.mp4");
  }

  @override
  void onUploadVideoEventDone(String url) {
    video = Video(
      videoUrl: url,
      videoThumbnail: thumbnail,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
      creatorId: currentUser.id,
      title: title,
      hashtag: extractHashtags(title),
    );
    sendVideoCreateEvent(video);
  }

  @override
  void onVideoCreateEventDone(e) {
    state.stopLoading();
    state.showAlertDialog(
      title: "Create post success",
      content: "Enjoy your video now",
      confirm: () {
        state.pushToScreen(ListVideoScreen(
          videos: [video],
          loadMoreVideos: () {},
          isShowBack: true,
        ));
      },
    );
  }
}

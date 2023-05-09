import 'package:image_picker/image_picker.dart';
import 'package:reel_t/events/upload/upload_video/upload_video_event.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/video/list_video/list_video_screen.dart';
import 'package:reel_t/shared_product/utils/editor/video_editor.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../../events/video/video_create/video_create_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/video/video.dart';
import 'video_preview_screen.dart';

class VideoPreviewBloc extends AbstractBloc<VideoPreviewScreenState>
    with UploadVideoEvent, VideoCreateEvent {
  late UserProfile currentUser;
  VideoEditor videoEditor = VideoEditor();
  String thumbnail = "";
  Video video = Video();
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    notifyDataChanged();
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
      hashtag: ["trending"],
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

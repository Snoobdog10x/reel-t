import 'dart:io';
import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:camerawesome/src/orchestrator/models/media_capture.dart';
import 'package:camerawesome/src/widgets/camera_awesome_builder.dart';
import 'package:camerawesome/src/widgets/utils/awesome_bouncing_widget.dart';
import 'package:camerawesome/src/widgets/utils/awesome_oriented_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAwesomeMediaPreview extends StatelessWidget {
  final MediaCapture? mediaCapture;
  final OnMediaTap onMediaTap;

  const CustomAwesomeMediaPreview({
    super.key,
    required this.mediaCapture,
    required this.onMediaTap,
  });

  @override
  Widget build(BuildContext context) {
    return AwesomeOrientedWidget(
      child: AspectRatio(
        aspectRatio: 1,
        child: AwesomeBouncingWidget(
          onTap: mediaCapture != null &&
                  onMediaTap != null &&
                  mediaCapture?.status == MediaCaptureStatus.success
              ? () => onMediaTap!(mediaCapture!)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white38,
                width: 2,
              ),
            ),
            child: ClipOval(child: _buildMedia(mediaCapture)),
          ),
        ),
      ),
    );
  }

  Widget _buildMedia(MediaCapture? mediaCapture) {
    switch (mediaCapture?.status) {
      case MediaCaptureStatus.capturing:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  ),
          ),
        );
      case MediaCaptureStatus.success:
        if (mediaCapture!.isPicture) {
          return Image(
            fit: BoxFit.cover,
            image: ResizeImage(
              FileImage(
                File(mediaCapture.filePath),
              ),
              width: 300,
            ),
          );
        } else {
          return FutureBuilder(
            builder: (context, data) {
              if (!data.hasData)
                return Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                );
              return Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.memory(
                      data.data!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
            future: convertVideoToThumbnail(mediaCapture.filePath),
          );
        }
      case MediaCaptureStatus.failure:
        return const Icon(
          Icons.error,
          color: Colors.white,
        );
      case null:
        return const SizedBox(
          width: 32,
          height: 32,
        );
    }
  }

  Future<Uint8List> convertVideoToThumbnail(String filePath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: filePath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
    return uint8list!;
  }
}

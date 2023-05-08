import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';

class CustomVideoTimer extends StatefulWidget {
  final CameraState state;
  const CustomVideoTimer({super.key, required this.state});

  @override
  State<CustomVideoTimer> createState() => _CustomVideoTimerState();
}

class _CustomVideoTimerState extends State<CustomVideoTimer> {
  List<Duration> videoMaxLengths = [
    Duration(seconds: 15),
    Duration(seconds: 60),
    Duration(minutes: 3),
  ];
  final CarouselController _controller = CarouselController();
  int _selected = 0;
  Duration _currentRecord = Duration(seconds: 15);
  Timer? cancelTimer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.state.when(
      onVideoMode: (_) {
        cancelTimer?.cancel();
        cancelTimer = null;
        _currentRecord = videoMaxLengths[_selected];
        return buildDefault();
      },
      onPreparingCamera: (_) => buildDefault(),
      onVideoRecordingMode: (_) {
        return buildRecording(_);
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget buildRecording(VideoRecordingCameraState _) {
    return StatefulBuilder(builder: (context, setState) {
      if (cancelTimer == null)
        cancelTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          _currentRecord = Duration(seconds: _currentRecord.inSeconds - 1);
          setState(() {});
          if (_currentRecord.inSeconds == 0) {
            _.stopRecording().whenComplete(() {
              _currentRecord = videoMaxLengths[_selected];
            });
            cancelTimer?.cancel();
            cancelTimer = null;
          }
        });

      return Container(
        alignment: Alignment.bottomCenter,
        child: Text(
          _printDuration(_currentRecord),
          style: TextStyle(
            color: Colors.white,
            fontSize: SharedTextStyle.NORMAL_SIZE,
            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
          ),
        ),
      );
    });
  }

  Widget buildDefault() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 65,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CarouselSlider(
            options: CarouselOptions(
              reverse: true,
              height: 21,
              initialPage: _selected,
              onPageChanged: (index, reason) {
                _selected = index;
                _currentRecord = videoMaxLengths[_selected];
                setState(() {});
                HapticFeedback.selectionClick();
              },
              enableInfiniteScroll: false,
              viewportFraction: 0.165,
            ),
            carouselController: _controller,
            items: videoMaxLengths.map((duration) {
              var index = videoMaxLengths.indexOf(duration);
              var isSelected = index == _selected;
              return Builder(
                builder: (BuildContext context) {
                  return AwesomeBouncingWidget(
                      onTap: () {
                        _currentRecord = videoMaxLengths[_selected];
                        setState(() {});
                        _controller.animateToPage(
                          index,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(milliseconds: 700),
                        );
                      },
                      child: buildDurationItem(duration, isSelected));
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildDurationItem(Duration duration, bool isSelected) {
    var text = "3m";
    if (duration.inSeconds == 15) text = "15s";
    if (duration.inSeconds == 60) text = "60s";

    return Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.black : Colors.white,
        fontSize: SharedTextStyle.NORMAL_SIZE,
        fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
      ),
    );
  }
}

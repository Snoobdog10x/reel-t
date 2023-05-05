import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'camera_ar_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

class CameraArScreen extends StatefulWidget {
  const CameraArScreen({super.key});

  @override
  State<CameraArScreen> createState() => CameraArScreenState();
}

class CameraArScreenState extends AbstractState<CameraArScreen> {
  late CameraArBloc bloc;

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
    bloc = CameraArBloc();
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
        return Consumer<CameraArBloc>(
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
    return CameraAwesomeBuilder.awesome(
      theme: AwesomeTheme(
        bottomActionsBackgroundColor: Colors.cyan.withOpacity(0.5),
        buttonTheme: AwesomeButtonTheme(
          backgroundColor: Colors.cyan.withOpacity(0.5),
          iconSize: 20,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16),
          // Tap visual feedback (ripple, bounce...)
          buttonBuilder: (child, onTap) {
            return ClipOval(
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  splashColor: Colors.cyan,
                  highlightColor: Colors.cyan.withOpacity(0.5),
                  onTap: onTap,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
      // Show the filter button on the top part of the screen
      topActionsBuilder: (state) => AwesomeTopActions(
        padding: EdgeInsets.zero,
        state: state,
        children: [
          Expanded(
            child: AwesomeFilterWidget(
              state: state,
              filterListPosition: FilterListPosition.aboveButton,
              filterListPadding: const EdgeInsets.only(top: 8),
            ),
          ),
        ],
      ),
      // Show some Text with same background as the bottom part
      middleContentBuilder: (state) {
        return Column(
          children: [
            const Spacer(),
            // Use a Builder to get a BuildContext below AwesomeThemeProvider widget
            Builder(builder: (context) {
              return Container(
                // Retrieve your AwesomeTheme's background color
                color: AwesomeThemeProvider.of(context)
                    .theme
                    .bottomActionsBackgroundColor,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "Take your best shot!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
      // Show Flash button on the left and Camera switch button on the right
      bottomActionsBuilder: (state) => AwesomeBottomActions(
        onMediaTap: (media) {
          print("recording");
          if (media.isRecordingVideo) {
            print("recording");

            return;
          }
          print("saving");

          bloc.saveVideo(media.filePath);
        },
        captureButton: AwesomeCaptureButton(
          state: state,
        ),
        state: state,
        left: AwesomeFlashButton(
          state: state,
        ),
        right: AwesomeCameraSwitchButton(
          state: state,
          scale: 1.0,
          onSwitchTap: (state) {
            state.switchCameraSensor(
              aspectRatio: state.sensorConfig.aspectRatio,
            );
          },
        ),
      ),

      saveConfig: SaveConfig.video(
        pathBuilder: () async {
          return bloc.path(CaptureMode.video);
        },
      ),
    );
  }

  @override
  void onDispose() {}
}

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

  Widget buildCamera() {
    return CameraAwesomeBuilder.awesome(
      // theme: AwesomeTheme(
      //   bottomActionsBackgroundColor: Colors.cyan.withOpacity(0.5),
      //   buttonTheme: AwesomeButtonTheme(
      //     backgroundColor: Colors.cyan.withOpacity(0.5),
      //     iconSize: 20,
      //     foregroundColor: Colors.white,
      //     padding: const EdgeInsets.all(16),
      //     buttonBuilder: (child, onTap) {
      //       return ClipOval(
      //         child: Material(
      //           color: Colors.transparent,
      //           shape: const CircleBorder(),
      //           child: InkWell(
      //             splashColor: Colors.cyan,
      //             highlightColor: Colors.cyan.withOpacity(0.5),
      //             onTap: onTap,
      //             child: child,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      // topActionsBuilder: (state) => Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 8.0),
      //       child: buildBackButton(),
      //     ),
      //     Expanded(
      //       child: buildLeftTopActions(state),
      //     )
      //   ],
      // ),
      // bottomActionsBuilder: (state) => Column(
      //   children: [
      //     AwesomeFilterWidget(
      //       state: state,
      //       filterListPosition: FilterListPosition.aboveButton,
      //       filterListPadding: const EdgeInsets.only(top: 8),
      //     ),
      //     AwesomeBottomActions(
      //       captureButton: AwesomeCaptureButton(
      //         state: state,
      //       ),
      //       onMediaTap: (mediaCapture) {
      //         print("save video");
      //         bloc.saveVideo(mediaCapture.filePath);
      //       },
      //       state: state,
      //       left: AwesomeCameraSwitchButton(
      //         state: state,
      //         scale: 1.0,
      //         onSwitchTap: (state) {
      //           state.switchCameraSensor(
      //             aspectRatio: state.sensorConfig.aspectRatio,
      //           );
      //         },
      //       ),
      //       right: Container(),
      //     ),
      //   ],
      // ),
      onMediaTap: (mediaCapture) {
        print("save video");
        bloc.saveVideo(mediaCapture.filePath);
      },
      saveConfig: SaveConfig.video(
        pathBuilder: () async {
          return bloc.path(CaptureMode.video);
        },
      ),
    );
  }

  Widget buildLeftTopActions(CameraState cameraState) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AwesomeFlashButton(
            state: cameraState,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget buildBackButton() => ClipOval(
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            splashColor: Colors.cyan,
            highlightColor: Colors.cyan.withOpacity(0.5),
            onTap: () {
              popTopDisplay();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      );
  Widget buildBody() {
    return buildCamera();
  }

  @override
  void onDispose() {}
}

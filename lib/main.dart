import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/models/video/video_data.dart';
import '../generated/app_init.dart';
import '../screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppInit.appStore.init();
  // VideoData().initSampleData();
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
    ),
  );
}

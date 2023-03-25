import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/models/video/video_data.dart';
import 'package:reel_t/screens/default/default_screen.dart';
import '../generated/app_init.dart';
import '../screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppInit.appStore.init();
  runApp(
    MaterialApp(
      home: DefaultScreen(),
    ),
  );
}

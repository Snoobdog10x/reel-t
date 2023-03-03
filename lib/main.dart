import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/screens/feed_screen.dart';
import 'package:reel_t/screens/sample_screen/sample_screen.dart';
import 'package:reel_t/service_locator.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(
    MaterialApp(
      home: FeedScreen(),
    ),
  );
}

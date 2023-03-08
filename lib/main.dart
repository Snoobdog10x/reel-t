import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/screens/feed/feed_screen.dart';
import 'package:reel_t/screens/signup/signup_screen.dart';
import 'package:reel_t/screens/welcome/welcome_screen.dart';
import 'package:reel_t/shared_product/first_init.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirstInit.appStore.init();
  runApp(
    MaterialApp(
      home: FeedScreen(),
    ),
  );
}

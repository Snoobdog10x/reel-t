import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/screens/feed/feed_screen.dart';
import 'package:reel_t/screens/login/login_screen.dart';
import 'package:reel_t/screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
    ),
  );
}

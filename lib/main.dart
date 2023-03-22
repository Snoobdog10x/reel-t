import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppInit.appStore.init();
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
    ),
  );
}

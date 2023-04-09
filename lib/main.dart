import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/screens/default/default_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // AppInit.init(isDebug: true, isInitSample: true);
  AppInit.init(isDebug: false, isInitSample: false);
  runApp(
    MaterialApp(
      home: DefaultScreen(),
    ),
  );
}

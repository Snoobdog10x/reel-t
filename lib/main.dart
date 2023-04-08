import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/default/default_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // try {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  //   await FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
  // } catch (e) {
  //   // ignore: avoid_print
  //   print(e);
  // }
  AppInit.init();
  runApp(
    MaterialApp(
      home: DefaultScreen(),
    ),
  );
}

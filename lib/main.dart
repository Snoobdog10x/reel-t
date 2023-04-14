import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:platform_local_notifications/platform_local_notifications.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/screens/reuseable/default/default_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PlatformNotifier.I.init(appName: "Reel T");
  // await AppInit.init(isDebug: true, isInitSample: false); // uncomment this if you run local only run by Thanh
  await AppInit.init(
    isDebug: false,
    isInitSample: false,
  ); // if not Thanh please run this
  runApp(
    OverlaySupport.global(
      child: MaterialApp(
        home: DefaultScreen(),
      ),
    ),
  );
}

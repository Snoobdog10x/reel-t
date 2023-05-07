import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_local_notifications/platform_local_notifications.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/screens/navigation/navigation_screen.dart';
import 'package:reel_t/screens/reuseable/default/default_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "reel_t",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await AppInit().init(
  //   isDebug: true,
  //   isInitSample: false,
  // ); // uncomment this if you run local only run by Thanh
  await AppInit().init(isInitSample: false);
  if (kDebugMode) {
    runApp(
      OverlaySupport.global(
        child: MaterialApp(
          home: DefaultScreen(),
        ),
      ),
    );
    return;
  }

  runApp(
    OverlaySupport.global(
      child: MaterialApp(
        home: NavigationScreen(),
      ),
    ),
  );
}

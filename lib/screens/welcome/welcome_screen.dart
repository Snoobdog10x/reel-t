import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/feed/feed_screen.dart';
import 'package:reel_t/screens/login/login_screen.dart';
import 'package:reel_t/screens/welcome/welcome_provider.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends AbstractState<WelcomeScreen> {
  late WelcomeProvider provider;
  @override
  AbstractProvider initProvider() {
    return provider;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    provider = WelcomeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<WelcomeProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              body: body,
              background: Colors.black,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Container(
      width: screenWidth(),
      height: screenHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "T",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            "Reel",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => FeedScreen()),
        (_) => false,
      );
    });
  }
}

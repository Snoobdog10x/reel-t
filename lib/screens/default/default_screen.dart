import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/messenger/home_chat/home_chat_screen.dart';
import 'package:reel_t/screens/navigation/navigation_screen.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import 'package:reel_t/screens/user/signup/signup_screen.dart';
import 'package:reel_t/screens/video/feed/feed_screen.dart';
import '../../generated/abstract_provider.dart';
import '../../generated/abstract_state.dart';
import 'default_provider.dart';
import '../../shared_product/widgets/default_appbar.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends AbstractState<DefaultScreen> {
  late DefaultProvider provider;
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
    provider = DefaultProvider();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<DefaultProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(appBarTitle: "Default Screens"),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NavigationScreen()),
              (_) => false,
            );
          },
          child: Text("Navigation"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeChatScreen()),
              (_) => false,
            );
          },
          child: Text("Home chat screen"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (_) => false,
            );
          },
          child: Text("Login"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignupScreen()),
              (_) => false,
            );
          },
          child: Text("Sign up"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => FeedScreen()),
              (_) => false,
            );
          },
          child: Text("Feed"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text("Navigation"),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  void onDispose() {}
}

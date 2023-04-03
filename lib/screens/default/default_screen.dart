import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/user/personal_information/personal_information_screen.dart';
import '../messenger/home_chat/home_chat_screen.dart';
import '../navigation/navigation_screen.dart';
import '../user/login/login_screen.dart';
import '../user/signup/signup_screen.dart';
import '../video/feed/feed_screen.dart';
import '../welcome/welcome_screen.dart';
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
            pushToScreen(NavigationScreen(), isReplace: true);
          },
          child: Text("Navigation"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(HomeChatScreen(), isReplace: true);
          },
          child: Text("Home chat screen"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(LoginScreen(), isReplace: true);
          },
          child: Text("Login"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(SignupScreen(), isReplace: true);
          },
          child: Text("Sign up"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(FeedScreen(), isReplace: true);
          },
          child: Text("Feed"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(WelcomeScreen(), isReplace: true);
          },
          child: Text("Welcome - init sample data"),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () {
            pushToScreen(PersonalInformationScreen(), isReplace: true);
          },
          child: Text("Personal information"),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  void onDispose() {}
}

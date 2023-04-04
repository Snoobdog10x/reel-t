import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/conversation/conversation_sample_data.dart';
import '../../models/user_profile/user_profile_sample_data.dart';
import '../../models/video/video_sample_data.dart';
import '../../generated/abstract_provider.dart';
import '../../generated/abstract_state.dart';
import '../../generated/app_init.dart';
import '../navigation/navigation_screen.dart';
import '../welcome/welcome_provider.dart';

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
  Future<void> onReady() async {
    // appStore.localUser.clearUser();
    // appStore.localMessenger.clearMessage();
    // VideoData().initVideoData();
    // UserProfileData().initUserProfileData();
    // ConversationData().initConversationData();
    pushToScreen(NavigationScreen(), isReplace: true);
  }
}

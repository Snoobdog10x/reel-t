import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/conversation/conversation_sample_data.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';
import '../../models/user_profile/user_profile_sample_data.dart';
import '../../models/video/video_sample_data.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../../generated/app_init.dart';
import '../navigation/navigation_screen.dart';
import 'welcome_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends AbstractState<WelcomeScreen>
    with TickerProviderStateMixin {
  late WelcomeBloc bloc;
  @override
  AbstractBloc initBloc() {
    return bloc;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    bloc = WelcomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<WelcomeBloc>(
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
          SvgPicture.asset(
            "lib/shared_product/assets/icon/REELT.svg",
            height: 80,
            width: 80,
          ),
          SizedBox(height: 8*5),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 30,
              fontWeight: SharedTextStyle.TITLE_WEIGHT,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('REEL'),
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
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
    await Future.delayed(Duration(seconds: 1));
    // await AppInit.init(isDebug: false, isInitSample: false);
    // pushToScreen(NavigationScreen(), isReplace: true);
  }
}

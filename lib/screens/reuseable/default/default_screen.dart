import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/messenger/detail_chat/detail_chat_screen.dart';
import 'package:reel_t/screens/messenger/detail_chat_setting/detail_chat_setting_screen.dart';
import 'package:reel_t/screens/messenger/new_chat/new_chat_screen.dart';
import 'package:reel_t/screens/search/search_screen.dart';
import 'package:reel_t/screens/user/email_authenticate/email_authenticate_screen.dart';
import 'package:reel_t/screens/user/personal_information/personal_information_screen.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';
import '../../messenger/home_chat/home_chat_screen.dart';
import '../../navigation/navigation_screen.dart';
import '../../user/login/login_screen.dart';
import '../../sub_setting_user/setting_and_privacy_personal/setting_and_privacy_personal_screen.dart';
import '../../user/signup/signup_screen.dart';
import '../../video/feed/feed_screen.dart';
import '../../welcome/welcome_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'default_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => DefaultScreenState();
}

class DefaultScreenState extends AbstractState<DefaultScreen> {
  late DefaultBloc bloc;
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
    bloc = DefaultBloc();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<DefaultBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(appBarTitle: "sample appbar"),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          TextButton(
            onPressed: () async {
              startLoading();
              await bloc.loginUser(UserProfile.fromJson({
                "id": "Pg8GacuZI2aqJRXLBDmXXZqGVwo1",
                "fullName": "duythanh1565",
                "email": "duythanh1565@gmail.com",
                "userName": "@duythanh1565",
                "bio": "More in Google Cloud",
                "birthday": "",
                "avatar":
                    "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F82462724_1799877263482769_8107949728500547584_n.jpeg?alt=media&token=674947fc-15d6-458a-a029-4d083b7c2923",
                "numFollower": 999,
                "numFollowing": 9999,
                "numLikes": 99999,
                "isOnline": false,
                "isActive": false,
                "isDeleted": false,
                "createAt": 0
              }));
              stopLoading();
            },
            child: Text("Fast login duy thanh"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () async {
              startLoading();
              await bloc.loginUser(UserProfile.fromJson({
                "id": "lSScQqjmqJVt9pVC8nHknMjsMIE2",
                "fullName": "heocon1565",
                "email": "heocon1565@gmail.com",
                "userName": "@heocon1565",
                "bio": "",
                "birthday": "",
                "avatar": "",
                "numFollower": 0,
                "numFollowing": 0,
                "numLikes": 0,
                "isOnline": false,
                "isActive": false,
                "isDeleted": false,
                "createAt": 0
              }));
              stopLoading();
            },
            child: Text("Fast login heo con"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () async {
              startLoading();
              await appStore.localUser.logout();
              await appStore.localSetting.clearSetting();
              stopLoading();
            },
            child: Text("Logout"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(
                DetailChatSettingScreen(
                    userProfile: UserProfile(
                        fullName: 'Do Huy Thong',
                        avatar:
                            'https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842')),
                isReplace: false,
              );
            },
            child: Text("Details Settings Chat"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(NavigationScreen(), isReplace: false);
            },
            child: Text("Navigation"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(HomeChatScreen(), isReplace: false);
            },
            child: Text("Home chat screen"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(LoginScreen(), isReplace: false);
            },
            child: Text("Login"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(SignupScreen(), isReplace: false);
            },
            child: Text("Sign up"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(
                  ProfileScreen(user: appStore.localUser.getCurrentUser()),
                  isReplace: false);
            },
            child: Text("Profile"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(WelcomeScreen(), isReplace: false);
            },
            child: Text("Welcome - init sample data"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(PersonalInformationScreen(), isReplace: false);
            },
            child: Text("Personal information"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(NewChatScreen(), isReplace: false);
            },
            child: Text("New Chat"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(SettingAndPrivacyPersonalScreen(), isReplace: false);
            },
            child: Text("Setting and privacy"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(
                  EmailAuthenticateScreen(
                    email: "duythanh1565@gmail.com",
                    password: "duythanh2001",
                  ),
                  isReplace: false);
            },
            child: Text("Email Authentication"),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              pushToScreen(SearchScreen(), isReplace: false);
            },
            child: Text("Search"),
          ),
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../messenger/home_chat/home_chat_screen.dart';
import '../video/feed/feed_screen.dart';
import '../navigation/navigation_bloc.dart';
import '../notification/notification_screen.dart';
import '../user/profile/profile_screen.dart';
import '../search/search_screen.dart';

import '../../shared_product/assets/icon/tik_tok_icons_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

enum NavigationPage { FEED, CHAT, NOTIFICATION, PROFILE }

class _NavigationScreenState extends AbstractState<NavigationScreen> {
  late NavigationBloc bloc;
  PageController _pageController = PageController();
  int currentScreen = NavigationPage.FEED.index;
  Map<int, Widget> pages = {
    NavigationPage.FEED.index: FeedScreen(),
    NavigationPage.CHAT.index: HomeChatScreen(),
    NavigationPage.NOTIFICATION.index: NotificationScreen(),
    NavigationPage.PROFILE.index: ProfileScreen(),
  };
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
    bloc = NavigationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<NavigationBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              body: body,
              isShowConnect: true,
              background: Colors.black,
              isSafe: false,
              bottomNavBar: buildBottomBar(),
            );
          },
        );
      },
    );
  }

  Widget buildBottomBar() {
    return Container(
      width: screenWidth(),
      height: screenHeight() * 0.1,
      child: Row(
        children: [
          Expanded(
            child: buildBottomBarItem(
              "Feed",
              Icons.chat,
              currentScreen == NavigationPage.FEED.index,
              onTap: () async {
                currentScreen = NavigationPage.FEED.index;
                _pageController.jumpToPage(NavigationPage.FEED.index);
                notifyDataChanged();
              },
            ),
          ),
          Expanded(
            child: buildBottomBarItem(
              "Chat",
              TikTokIcons.messages,
              currentScreen == NavigationPage.CHAT.index,
              onTap: () {
                currentScreen = NavigationPage.CHAT.index;
                _pageController.jumpToPage(NavigationPage.CHAT.index);

                notifyDataChanged();
              },
            ),
          ),
          Expanded(child: buildAddVideoButton()),
          Expanded(
            child: buildBottomBarItem(
              "Notification",
              TikTokIcons.messages,
              currentScreen == NavigationPage.NOTIFICATION.index,
              onTap: () {
                currentScreen = NavigationPage.NOTIFICATION.index;
                _pageController.jumpToPage(NavigationPage.NOTIFICATION.index);

                notifyDataChanged();
              },
            ),
          ),
          Expanded(
            child: buildBottomBarItem(
              "Profile",
              TikTokIcons.profile,
              currentScreen == NavigationPage.PROFILE.index,
              onTap: () {
                currentScreen = NavigationPage.PROFILE.index;
                _pageController.jumpToPage(NavigationPage.PROFILE.index);
                notifyDataChanged();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildAddVideoButton({Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        children: [
          SizedBox(height: 8),
          Container(
            height: 40,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBarItem(
    String? title,
    IconData? icon,
    bool isSelect, {
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        children: [
          Expanded(
              child: Icon(
            icon,
            color: isSelect ? Colors.white : Colors.white70,
          )),
          Expanded(
              child: Text(
            title ?? "",
            style: TextStyle(
              color: isSelect ? Colors.white : Colors.white70,
            ),
          ))
        ],
      ),
    );
  }

  Widget buildBody() {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: pages.values.toList(),
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

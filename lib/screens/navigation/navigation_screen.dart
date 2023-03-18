import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/feed/feed_screen.dart';
import 'package:reel_t/screens/navigation/navigation_provider.dart';
import 'package:reel_t/screens/notification/notification_screen.dart';
import 'package:reel_t/screens/profile/profile_screen.dart';
import 'package:reel_t/screens/search/search_screen.dart';

import '../../shared_product/assets/icon/tik_tok_icons_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

enum NavigationPage { FEED, SEARCH, NOTIFICATION, PROFILE }

class _NavigationScreenState extends AbstractState<NavigationScreen> {
  late NavigationProvider provider;
  int currentScreen = NavigationPage.FEED.index;
  Map<int, Widget> pages = {
    NavigationPage.FEED.index: FeedScreen(),
    NavigationPage.SEARCH.index: SearchScreen(),
    NavigationPage.NOTIFICATION.index: NotificationScreen(),
    NavigationPage.PROFILE.index: ProfileScreen(),
  };
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
    provider = NavigationProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<NavigationProvider>(
          builder: (context, value, child) {
            var body = pages[currentScreen];
            return buildScreen(
              body: body,
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
              TikTokIcons.home,
              currentScreen == NavigationPage.FEED.index,
              onTap: () {
                currentScreen = NavigationPage.FEED.index;
                notifyDataChanged();
              },
            ),
          ),
          Expanded(
            child: buildBottomBarItem(
              "Search",
              TikTokIcons.search,
              currentScreen == NavigationPage.SEARCH.index,
              onTap: () {
                currentScreen = NavigationPage.SEARCH.index;
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
    return Column(
      children: [
        Expanded(child: Container()),
        Expanded(child: Container()),
      ],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

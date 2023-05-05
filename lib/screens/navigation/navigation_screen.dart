import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/screens/video/camera_ar/camera_ar_screen.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../messenger/home_chat/home_chat_screen.dart';
import '../video/feed/feed_screen.dart';
import '../navigation/navigation_bloc.dart';
import '../notification/notification_screen.dart';
import '../user/profile/profile_screen.dart';

import '../../shared_product/assets/icon/tik_tok_icons_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => NavigationScreenState();
}

enum NavigationPage { FEED, CHAT, NOTIFICATION, PROFILE }

class NavigationScreenState extends AbstractState<NavigationScreen> {
  late NavigationBloc bloc;
  PreloadPageController _pageController = PreloadPageController();
  int currentScreen = NavigationPage.FEED.index;
  late Map<int, Widget> pages;
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
    bloc.currentUser = appStore.localUser.getCurrentUser();
    bloc.init();

    pages = {
      NavigationPage.FEED.index: FeedScreen(),
      NavigationPage.CHAT.index: HomeChatScreen(),
      NavigationPage.NOTIFICATION.index:
          NotificationScreen(callBackNewNotification: () {
        bloc.sendRetrieveNotificationNumsEvent(bloc.currentUser);
      }),
      NavigationPage.PROFILE.index: ProfileScreen(
        user: bloc.currentUser,
      ),
    };
    appStore.setGlobalNavigationNotifyDataChanged(notifyDataChanged);
    if (isLogin())
      appStore.receiveNotification
          .setNotificationStream(appStore.localUser.getCurrentUser().id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<NavigationBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            var isBlackBackground = currentScreen == 0;
            return buildScreen(
              body: body,
              isShowConnect: true,
              background: isBlackBackground
                  ? Colors.black
                  : Color.fromARGB(255, 240, 240, 240),
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
      height: screenHeight() * 0.105,
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
              TikTokIcons.chat_bubble,
              currentScreen == NavigationPage.CHAT.index,
              onTap: () {
                currentScreen = NavigationPage.CHAT.index;
                _pageController.jumpToPage(NavigationPage.CHAT.index);
                notifyDataChanged();
              },
              numNotification: 10,
            ),
          ),
          Expanded(
            child: buildAddVideoButton(
              onTap: () {
                pushToScreen(CameraArScreen());
              },
            ),
          ),
          Expanded(
            child: buildBottomBarItem(
              "Notification",
              TikTokIcons.messages,
              currentScreen == NavigationPage.NOTIFICATION.index,
              onTap: () {
                // print(bloc.countNotifications);
                // print(bloc.listNotification);
                currentScreen = NavigationPage.NOTIFICATION.index;
                _pageController.jumpToPage(NavigationPage.NOTIFICATION.index);
                notifyDataChanged();
              },
              numNotification:
                  isCheckCountNotification() ? bloc.countNotifications : null,
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
    var isBlackBackground = currentScreen == 0;
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 35,
            width: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isBlackBackground ? Colors.white : Colors.black,
            ),
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: isBlackBackground ? Colors.black : Colors.white,
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
    int? numNotification,
  }) {
    var isBlackBackground = currentScreen == 0;
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      icon,
                      color: isSelect
                          ? isBlackBackground
                              ? Colors.white
                              : Colors.black
                          : isBlackBackground
                              ? Colors.white70
                              : Colors.black45,
                    ),
                  ),
                  if (numNotification != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          '${numNotification}',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Text(
                title ?? "",
                style: TextStyle(
                  color: isSelect
                      ? isBlackBackground
                          ? Colors.white
                          : Colors.black
                      : isBlackBackground
                          ? Colors.white70
                          : Colors.black45,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return PreloadPageView(
      preloadPagesCount: 4,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: pages.values.toList(),
    );
  }

  bool isCheckCountNotification() {
    if (bloc.countNotifications == 0) return false;
    return true;
  }

  @override
  void onDispose() {}

  @override
  void onPopWidget(String previousScreen) {
    // TODO: implement onPopWidget
    super.onPopWidget(previousScreen);
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

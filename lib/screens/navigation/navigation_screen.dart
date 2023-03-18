import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/feed/feed_screen.dart';
import 'package:reel_t/screens/navigation/navigation_provider.dart';
import 'package:reel_t/screens/notification/notification_screen.dart';
import 'package:reel_t/screens/profile_screen.dart';
import 'package:reel_t/screens/search/search_screen.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

enum NavigationPage { FEED, SEARCH, NOTIFICATION, PROFILE }

class _NavigationScreenState extends AbstractState<NavigationScreen> {
  late NavigationProvider provider;
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
    return Column(
      children: [],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

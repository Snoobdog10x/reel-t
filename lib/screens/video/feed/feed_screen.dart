import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/search/search_screen.dart';
import '../../../models/video/video.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'feed_bloc.dart';
import '../list_video/list_video_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => FeedScreenState();
}

class FeedScreenState extends AbstractState<FeedScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late FeedBloc bloc;
  late TabController tabController;
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
    bloc = FeedBloc();
    tabController = TabController(length: 2, vsync: this);
    bloc.sendRetrieveVideos();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<FeedBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              body: body,
              isSafe: false,
              background: Colors.black,
            );
          },
        );
      },
    );
  }

  Widget buildAppBar() {
    return Container(
      margin: EdgeInsets.only(top: paddingTop()),
      height: 50,
      width: screenWidth(),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 8,
            child: Container(
              height: 30,
              alignment: Alignment.center,
              child: TabBar(
                controller: tabController,
                isScrollable: true, // here
                indicator: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(13),
                ),
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: "SF Pro Text",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                  fontFamily: "SF Pro Text",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "For you",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Following",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                pushToScreen(SearchScreen());
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        TabBarView(
          controller: tabController,
          children: [
            ListVideoScreen(
              videos: bloc.forYou,
              loadMoreVideos: () {
                bloc.sendRetrieveVideos();
              },
            ),
            ListVideoScreen(
              videos: bloc.following,
              loadMoreVideos: () {},
            ),
          ],
        ),
        buildAppBar(),
      ],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

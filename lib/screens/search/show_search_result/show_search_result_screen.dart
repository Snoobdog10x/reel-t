import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';
import 'package:reel_t/screens/video/list_video/list_video_screen.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';
import 'package:reel_t/shared_product/widgets/video_player_item.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'show_search_result_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class ShowSearchResultScreen extends StatefulWidget {
  final String searchText;
  const ShowSearchResultScreen({super.key, this.searchText = ""});

  @override
  State<ShowSearchResultScreen> createState() => ShowSearchResultScreenState();
}

class ShowSearchResultScreenState extends AbstractState<ShowSearchResultScreen>
    with TickerProviderStateMixin {
  late ShowSearchResultBloc bloc;
  late TextEditingController _searchController;
  late TabController tabController;
  bool isVideoTab = true;
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
    bloc = ShowSearchResultBloc();
    tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController(text: widget.searchText);
    bloc.sendSearchUserEvent(widget.searchText);
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
        return Consumer<ShowSearchResultBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: buildAppBar(),
              body: body,
              padding: EdgeInsets.symmetric(horizontal: 8),
            );
          },
        );
      },
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    popTopDisplay();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              Expanded(flex: 11, child: buildSearch()),
            ],
          ),
          buildTapBar(),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Hot girls",
          hintStyle: TextStyle(fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        // controller: widget.controller,
        cursorColor: Colors.green,
        textInputAction: TextInputAction.search,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        readOnly: true,
        onTap: () {
          popTopDisplay();
        },
      ),
    );
  }

  Widget buildTapBar() {
    var lableStyle = TextStyle(
      fontSize: SharedTextStyle.SUB_TITLE_SIZE,
      color: Colors.black,
      fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
    );
    var unlableStyle = TextStyle(
      fontSize: SharedTextStyle.SUB_TITLE_SIZE,
      color: Colors.black,
      fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
    );
    return Container(
      height: 30,
      child: TabBar(
        controller: tabController,
        labelStyle: lableStyle,
        unselectedLabelStyle: unlableStyle,
        tabs: [
          Text(
            "Videos",
            style: lableStyle,
          ),
          Text(
            "user",
            style: lableStyle,
          ),
        ],
      ),
    );
  }

  Widget buildGridSearchVideoResults() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: screenHeight() * 0.35,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: bloc.searchVideoResult.length,
      itemBuilder: (context, index) {
        var video = bloc.searchVideoResult[index];
        return buildVideoItem(video);
      },
    );
  }

  Widget buildVideoItem(Video video) {
    var user = bloc.users[video.id] ?? UserProfile(id: video.creatorId);
    return GestureDetector(
      onTap: () {
        pushToScreen(ListVideoScreen(
          videos: bloc.searchVideoResult,
          loadMoreVideos: () {},
          isShowBack: true,
        ));
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight(),
            width: screenWidth(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: VideoThumbnailDisplay(
                thumbnail: video.videoThumbnail,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              user.userName,
              style: TextStyle(
                fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                color: Colors.white,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridSearchUserResults() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: screenHeight() * 0.35,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: bloc.searchUserResult.length,
      itemBuilder: (context, index) {
        var user = bloc.searchUserResult[index];
        return buildBlockUserItem(user);
      },
    );
  }

  Widget buildBlockUserItem(UserProfile user) {
    return GestureDetector(
      onTap: () {
        pushToScreen(ProfileScreen(
          user: user,
          isBack: true,
        ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
              image: user.avatar.isEmpty
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(user.avatar),
                      fit: BoxFit.cover,
                    ),
            ),
            alignment: Alignment.center,
            child: user.avatar.isEmpty
                ? Icon(
                    Icons.people,
                    size: screenWidth() * 0.4,
                    color: Colors.white,
                  )
                : null,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              user.userName,
              style: TextStyle(
                fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                color: Colors.white,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return TabBarView(
      controller: tabController,
      children: [
        buildGridSearchVideoResults(),
        buildGridSearchUserResults(),
      ],
    );
  }

  @override
  void onDispose() {}
}

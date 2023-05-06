import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/user/profile/profile_screen.dart';
import 'package:reel_t/screens/video/list_video/list_video_screen.dart';
import 'package:reel_t/screens/video/list_video/models/creator_detail.dart';
import 'package:reel_t/screens/video/list_video/models/video_detail.dart';
import 'package:reel_t/shared_product/assets/icon/tik_tok_icons_icons.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';
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
  final TextStyle subTitleStyle = TextStyle(
    fontSize: 11,
    fontWeight: SharedTextStyle.NORMAL_WEIGHT,
  );
  final TextStyle titleStyle = TextStyle(
    fontSize: SharedTextStyle.SUB_TITLE_SIZE,
    fontWeight: SharedTextStyle.TITLE_WEIGHT,
  );
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
      color: Colors.grey,
      fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
    );
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 8),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: lableStyle,
        unselectedLabelStyle: unlableStyle,
        tabs: [
          Text("Videos"),
          Text("Users"),
        ],
      ),
    );
  }

  Widget buildGridSearchVideoResults() {
    var videos = bloc.searchVideoResult.values.toList();
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: screenHeight() * 0.35,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        var video = videos[index];
        return buildVideoItem(video);
      },
    );
  }

  Widget buildVideoItem(VideoDetail video) {
    var user = bloc.creatorDetails[video.video.creatorId] ??
        CreatorDetail(UserProfile());
    return GestureDetector(
      onTap: () {
        pushToScreen(ListVideoScreen(
          videos: bloc.searchVideoResult.values
              .map((videoDetail) => videoDetail.video)
              .toList(),
          loadMoreVideos: () {},
          isShowBack: true,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: screenHeight(),
                  width: screenWidth(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: VideoThumbnailDisplay(
                      thumbnail: video.video.videoThumbnail,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 8),
                  child: Text(
                    user.userProfile.userName,
                    style: TextStyle(
                      fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                      color: Colors.white,
                      fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(video.video.title),
          SizedBox(height: 6),
          Row(
            children: [
              CircleImage(user.userProfile.avatar, radius: 25),
              SizedBox(width: 5),
              Expanded(
                  child: Text(
                user.userProfile.fullName,
                style: subTitleStyle,
              )),
              Icon(
                TikTokIcons.heart,
                size: 12,
                color: Color.fromARGB(255, 255, 155, 155),
              ),
              SizedBox(width: 2),
              Text(
                FormatUtility.formatNumber(video.video.likesNum),
                style: subTitleStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildUserList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListView.separated(
        itemBuilder: (context, index) {
          var user = bloc.creatorDetails.values.toList()[index];
          return buildUserItem(user);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemCount: bloc.creatorDetails.length,
      ),
    );
  }

  Widget buildUserItem(CreatorDetail userProfile) {
    bool isFollow = userProfile.isFollow();
    return Row(
      children: [
        CircleImage(userProfile.userProfile.avatar, radius: 50),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userProfile.userProfile.fullName, style: titleStyle),
              Text("${userProfile.userProfile.userName}", style: subTitleStyle),
              Text(bloc.formatUserStatistic(userProfile.userProfile)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isFollow ? Colors.white : Colors.red,
            ),
            alignment: Alignment.center,
            width: screenWidth() * 0.25,
            child: Text(
              isFollow ? "Following" : "Follow",
              style: TextStyle(
                color: isFollow ? Colors.black : Colors.white,
                fontWeight: SharedTextStyle.NORMAL_WEIGHT,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return TabBarView(
      controller: tabController,
      children: [
        buildGridSearchVideoResults(),
        buildUserList(),
      ],
    );
  }

  @override
  void onDispose() {}
}

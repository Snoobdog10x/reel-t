import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/assets/icon/tik_tok_icons_icons.dart';
import '../../../shared_product/utils/format_utlity.dart';
import '../../../shared_product/utils/shared_text_style.dart';
import '../../../shared_product/widgets/button/three_row_button.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import '../../reuseable/commingsoon/commingsoon_screen.dart';
import '../login/login_screen.dart';
import 'profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile user;
  final bool isBack;
  const ProfileScreen({
    super.key,
    required this.user,
    this.isBack = false,
  });

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends AbstractState<ProfileScreen> {
  late ProfileBloc bloc;

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
    bloc = ProfileBloc();
    bloc.init();
    bloc.sendRetrieveUserVideoEvent(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<ProfileBloc>(
          builder: (context, value, child) {
            var appBar = buildAppbar();
            var body = buildBody();
            return buildScreen(
              appBar: appBar,
              body: body,
              notLoggedBody: buildLoggedBody(),
              padding: EdgeInsets.symmetric(horizontal: 8),
              isSafeBottom: false,
            );
          },
        );
      },
    );
  }

  Widget buildLoggedBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          TikTokIcons.profile,
          size: 150,
          color: Colors.grey[300],
        ),
        SizedBox(height: 8),
        Text(
          "Your profile will be shown here",
          style: TextStyle(
            fontSize: SharedTextStyle.SUB_TITLE_SIZE,
            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: screenWidth() * 0.6,
          child: ThreeRowButton(
            onTap: () {
              pushToScreen(LoginScreen());
            },
            title: Text(
              "Sign up",
              style: TextStyle(
                fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  if (widget.isBack) {
                    popTopDisplay();
                    return;
                  }
                  pushToScreen(CommingsoonScreen());
                },
                child: Icon(
                  widget.isBack
                      ? Icons.arrow_back_ios_new_outlined
                      : CupertinoIcons.gift_fill,
                  color: widget.isBack ? Colors.black : Colors.greenAccent,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                print("hihi");
              },
              child: Center(
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.user.fullName,
                        style: TextStyle(
                          fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                          fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommingsoonScreen(),
                      ),
                    );
                  },
                  child: Icon(
                    CupertinoIcons.paw,
                    // Profile view history will appear here
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    CupertinoIcons.line_horizontal_3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildAvatar(),
          SizedBox(height: 16),
          buildStatistic(),
          SizedBox(height: 8),
          buildButtonMore(),
          SizedBox(height: 8),
          buildBio(),
          SizedBox(height: 10),
          buildShowVideo(),
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return Column(
      children: <Widget>[
        CircleImage(
          widget.user.avatar,
          radius: 100,
        ),
        SizedBox(height: 8),
        Text(
          widget.user.userName,
          style: TextStyle(fontWeight: SharedTextStyle.NORMAL_WEIGHT),
        ),
      ],
    );
  }

  Widget buildStatistic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStatisticItems(widget.user.numFollowing, 'Following'),
        SizedBox(width: 14),
        Container(
          color: Color.fromARGB(255, 200, 200, 200),
          height: 30,
          width: 1,
        ),
        SizedBox(width: 14),
        buildStatisticItems(widget.user.numFollower, 'Follower'),
        SizedBox(width: 14),
        Container(
          color: Color.fromARGB(255, 200, 200, 200),
          height: 30,
          width: 1,
        ),
        SizedBox(width: 14),
        buildStatisticItems(widget.user.numLikes, 'Likes'),
      ],
    );
  }

  Widget buildStatisticItems(int value, String title) {
    return Column(
      children: [
        Text(
          FormatUtility.formatNumber(value),
          style: TextStyle(
            fontSize: 17,
            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
          ),
        ),
        SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget buildButtonMore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: SharedTextStyle.NORMAL_SIZE,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 210, 210, 210),
                elevation: 0),
          ),
        ),
        SizedBox(width: 6),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 210, 210, 210),
                elevation: 0),
            child: Text(
              'Add friends',
              style: TextStyle(
                  fontSize: SharedTextStyle.NORMAL_SIZE,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBio() {
    return Text(
      widget.user.bio,
      style: TextStyle(
        fontSize: SharedTextStyle.NORMAL_SIZE,
        fontWeight: SharedTextStyle.NORMAL_WEIGHT,
      ),
    );
  }

  Widget buildShowOption() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                CupertinoIcons.circle_grid_hex,
                size: 20,
              ),
            ),
            Expanded(
              flex: 2,
              child: Icon(
                CupertinoIcons.lock_shield,
                size: 20,
              ),
            ),
            Expanded(
              flex: 2,
              child: Icon(
                CupertinoIcons.tag,
                size: 20,
              ),
            ),
            Expanded(
              flex: 2,
              child: Icon(
                CupertinoIcons.circle_grid_hex,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Container(
            color: Color.fromARGB(255, 200, 200, 200),
            height: 2,
            width: screenWidth()),
      ],
    );
  }

  Widget buildShowVideo() {
    var videos = bloc.userVideos;
    var blockHeight = videos.length * screenHeight() * 0.2;
    return Container(
      decoration: BoxDecoration(
        border: blockHeight == 0
            ? null
            : Border(
                top: BorderSide(
                  width: 1.5,
                  color: Color.fromARGB(255, 200, 200, 200),
                ),
              ),
      ),
      padding: EdgeInsets.only(top: 8),
      height: blockHeight,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          mainAxisExtent: screenHeight() * 0.2,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return buildUserVideo();
        },
      ),
    );
  }

  Widget buildUserVideo() {
    return Container(
      color: Colors.blueAccent,
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

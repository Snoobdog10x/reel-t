import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/utils/format_utlity.dart';
import '../../../shared_product/utils/shared_text_style.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import '../../reuseable/commingsoon/commingsoon_screen.dart';
import 'profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile user;
  const ProfileScreen({
    super.key,
    required this.user,
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
            );
          },
        );
      },
    );
  }

  Widget buildAppbar() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {
              pushToScreen(CommingsoonScreen());
            },
            icon: Icon(
              CupertinoIcons.gift_fill,
              color: Colors.greenAccent,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.user.fullName,
                  style: TextStyle(
                      fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                      fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT),
                ),
                IconButton(
                  onPressed: () {}, //Switch Accounts
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommingsoonScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.paw,
                    // Profile view history will appear here
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.line_horizontal_3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight() * 0.03,
            color: Color.fromARGB(255, 235, 235, 235),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person, size: 16),
                Text('Private account',
                    style: TextStyle(
                      fontSize: SharedTextStyle.NORMAL_SIZE,
                      fontWeight: SharedTextStyle.NORMAL_WEIGHT,
                    )),
              ],
            ),
          ),
          SizedBox(height: 8),
          buildAvatar(),
          buildStatistic(),
          SizedBox(height: 8),
          buildButtonMore(),
          SizedBox(height: 8),
          buildBio(),
          SizedBox(height: 10),
          buildShowOption(),
          SizedBox(height: 4),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '@' + widget.user.userName,
              style: TextStyle(fontWeight: SharedTextStyle.NORMAL_WEIGHT),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.qrcode,
                color: Colors.grey,
                size: 16,
              ),
            ),
          ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(),
        ),
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

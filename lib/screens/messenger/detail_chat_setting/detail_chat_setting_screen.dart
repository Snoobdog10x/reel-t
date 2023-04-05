import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../screens/commingsoon/commingsoon_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'detail_chat_setting_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class DetailChatSettingScreen extends StatefulWidget {
  final Conversation conversation;
  const DetailChatSettingScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<DetailChatSettingScreen> createState() =>
      DetailChatSettingScreenState();
}

class DetailChatSettingScreenState
    extends AbstractState<DetailChatSettingScreen> {
  late DetailChatSettingBloc bloc;
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
    bloc = DetailChatSettingBloc();
    bloc.init(widget.conversation);
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
        return Consumer<DetailChatSettingBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              background: Color.fromARGB(255, 240, 240, 240),
              padding: EdgeInsets.only(left: 16, right: 16),
              appBar: DefaultAppBar(
                onTapBackButton: () {
                  popTopDisplay();
                },
              ),
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
        children: <Widget>[
          CircleImage(
            bloc.conversation.secondUser.first.avatar,
            radius: 100,
          ),
          SizedBox(height: 10),
          Text(
            bloc.conversation.secondUser.first.fullName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14),
          buildIcon(),
          SizedBox(height: 20),
          buildCustomization(),
          SizedBox(height: 20),
          buildMoreActions(),
          SizedBox(height: 20),
          buildPrivacyAndSupport(),
        ],
      ),
    );
  }

  Widget buildIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildIconItem(CupertinoIcons.person_crop_circle, 'Profile', () {}),
        SizedBox(width: 16),
        buildIconItem(CupertinoIcons.bell_fill, 'Mute', () {}),
      ],
    );
  }

  Widget buildCustomization() {
    return Container(
      height: screenHeight() * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Customization',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.smallcircle_fill_circle_fill,
                            'Theme', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CommingsoonScreen(),
                        ),
                      );
                    }, true, Colors.lightBlueAccent)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.hand_thumbsup_fill,
                            'Quick reaction',
                            () {},
                            true,
                            Colors.blueGrey)),
                    Expanded(
                        child: buildOptionItem(CupertinoIcons.textformat_alt,
                            'Nicknames', () {}, true, Colors.black)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.wand_stars_inverse,
                            'Word effects',
                            () {},
                            false,
                            Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoreActions() {
    return Container(
      height: screenHeight() * 0.385,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'More Actions',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.person_3,
                            'Create group chat with Thanh',
                            () {},
                            true,
                            Colors.black)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.photo_fill,
                            'View media, files & links',
                            () {},
                            true,
                            Colors.black)),
                    Expanded(
                        child: buildOptionItem(CupertinoIcons.pin,
                            'Pinned Messages', () {}, true, Colors.black)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.padlock,
                            'Go to secret conversation',
                            () {},
                            true,
                            Colors.black)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.search,
                            'Search in conversation',
                            () {},
                            true,
                            Colors.black)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.bell_fill,
                            'Notifications & sounds',
                            () {},
                            true,
                            Colors.black)),
                    Expanded(
                        child: buildOptionItem(CupertinoIcons.share,
                            'Share contact', () {}, false, Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrivacyAndSupport() {
    return Container(
      height: screenHeight() * 0.165,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Privacy & Support',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: buildOptionItem(CupertinoIcons.slash_circle_fill,
                            'Restrict', () {}, true, Colors.black)),
                    Expanded(
                        child: buildOptionItem(CupertinoIcons.minus_circle_fill,
                            'Block', () {}, true, Colors.blueGrey)),
                    Expanded(
                        child: buildOptionItem(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            'Report',
                            () {},
                            false,
                            Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconItem(IconData icon, String iconTitle, Function onTapAction) {
    return Container(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.transparent,
              elevation: 0,
              side: BorderSide(
                color: Colors.transparent,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 10,
                  color: Color.fromARGB(255, 248, 249, 249),
                ),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            onPressed: () {
              onTapAction();
            },
          ),
          Text(iconTitle, style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  Widget buildOptionItem(IconData icon, String optionTitle,
      Function onTapAction, bool isDivide, Color colors) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Container(
        width: screenWidth(),
        height: screenHeight(),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: colors,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                height: screenHeight(),
                decoration: isDivide
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.05,
                          ),
                        ),
                      )
                    : null,
                child: Text(
                  optionTitle,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        onTapAction();
      },
    );
  }

  @override
  void onDispose() {}
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'setting_and_privacy_personal_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class SettingAndPrivacyPersonalScreen extends StatefulWidget {
  const SettingAndPrivacyPersonalScreen({super.key});

  @override
  State<SettingAndPrivacyPersonalScreen> createState() =>
      SettingAndPrivacyPersonalScreenState();
}

class SettingAndPrivacyPersonalScreenState
    extends AbstractState<SettingAndPrivacyPersonalScreen> {
  late SettingAndPrivacyPersonalBloc bloc;
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
    bloc = SettingAndPrivacyPersonalBloc();
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
        return Consumer<SettingAndPrivacyPersonalBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Settings and privacy",
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
        children: [
          buildAccount(),
          SizedBox(height: 20),
          buildContentAndDisplay(),
          SizedBox(height: 20),
          buildCacheAndCellular(),
          SizedBox(height: 20),
          buildSupportAndAbout(),
          SizedBox(height: 20),
          buildLogin(),
        ],
      ),
    );
  }

  Widget buildAccount() {
    return Container(
      height: screenHeight() * 0.42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
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
                        CupertinoIcons.person_fill,
                        'Account',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.lock_fill,
                        'Privacy',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                          CupertinoIcons.shield_fill,
                          'Security',
                          () {},
                          true,
                          Color.fromARGB(255, 160, 160, 160)),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.creditcard_fill,
                        'Balance',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.shopping_cart,
                        'My Shopping',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.arrowshape_turn_up_right_fill,
                        'Share Profile',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContentAndDisplay() {
    return Container(
      height: screenHeight() * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Content & Display',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
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
                        CupertinoIcons.bell_fill,
                        'Notifications',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.play_rectangle_fill,
                        'LIVE',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                          CupertinoIcons.textformat_abc_dottedunderline,
                          'Language',
                          () {},
                          true,
                          Color.fromARGB(255, 160, 160, 160)),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.clock_solid,
                        'Comment and watch history',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.video_camera_solid,
                        'Content preferences',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.speaker_fill,
                        'Ads',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.play_rectangle_fill,
                        'Playback',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.moon_fill,
                        'Display',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.hourglass_tophalf_fill,
                        'Screen time',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.home,
                        'Family Pairing',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCacheAndCellular() {
    return Container(
      height: screenHeight() * 0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Cache & Cellular',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
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
                        CupertinoIcons.trash_fill,
                        'Free up space',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.bolt_horizontal_circle_fill,
                        'Data Saver',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupportAndAbout() {
    return Container(
      height: screenHeight() * 0.21,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Support & About',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
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
                        CupertinoIcons.flag_fill,
                        'Report a problem',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.text_bubble_fill,
                        'Support',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.exclamationmark_circle_fill,
                        'Terms and Policies',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogin() {
    return Container(
      height: screenHeight() * 0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 130, 130, 130),
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
                      child: ElevatedButton(
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
                                CupertinoIcons.arrow_2_circlepath_circle_fill,
                                size: 20,
                                color: Color.fromARGB(255, 160, 160, 160),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: screenHeight(),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Switch account',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              CircleImage(
                                appStore.localUser.getCurrentUser().avatar,
                                radius: 25,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                CupertinoIcons.forward,
                                size: 20,
                                color: Color.fromARGB(255, 160, 160, 160),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        CupertinoIcons.decrease_quotelevel,
                        'Log out',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
              size: 20,
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
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
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

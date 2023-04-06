import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/utils/shared_text_style.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import '../../commingsoon/commingsoon_screen.dart';
import 'profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
            var appBar = buildAppbar(bloc.currentUser.fullName);
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

  Widget buildAppbar(
    String? userName,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CommingsoonScreen(),
                ),
              );
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
                  userName!,
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

  Widget buildBody(
    // String? currentUserName,
    // String? currentUserAvatar,
  ) {
    return Column(
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
        Container(
          height: screenHeight() * 0.4,
          child: Row(
            children: <Widget>[],
          ),
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

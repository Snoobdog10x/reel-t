import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import 'profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends AbstractState<ProfileScreen> {
  late ProfileProvider provider;

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
    provider = ProfileProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<ProfileProvider>(
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

  Widget buildAppbar({
    String? avataUrl,
    String? userName,
  }) {
    return ThreeRowAppBar(
      firstWidget: GestureDetector(
        onTap: () {
          popTopDisplay();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      secondWidget: Container(
        child: Row(
          children: <Widget>[
            avataUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      avataUrl,
                    ),
                    radius: 20,
                  )
                : Container(),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                child: Text(userName.toString()),
              ),
            )
          ],
        ),
      ),
      lastWidget: Padding(
        padding: EdgeInsets.only(left: 60),
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                CupertinoIcons.phone_fill,
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                ),
              ),
            ),
          ],
        ),
      ),
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

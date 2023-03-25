import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import 'detail_chat_screen_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class DetailChatScreenScreen extends StatefulWidget {
  final Conversation conversation;
  const DetailChatScreenScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<DetailChatScreenScreen> createState() => _DetailChatScreenScreenState();
}

class _DetailChatScreenScreenState
    extends AbstractState<DetailChatScreenScreen> {
  late DetailChatScreenProvider provider;
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
    provider = DetailChatScreenProvider();
    widget.conversation;
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<DetailChatScreenProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            var bottom = buidBottom();
            UserProfile user = widget.conversation.user2!;
            return buildScreen(
              appBar: buildAppbar(
                avataUrl: user.avatar,
                userName: user.fullName,
              ),
              body: body,
              bottomNavBar: bottom,
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
                Icons.phone,
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: GestureDetector(
                onTap: () {
                  popTopDisplay();
                },
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

  Widget buidBottom() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "Write message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none),
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  void onDispose() {}
}

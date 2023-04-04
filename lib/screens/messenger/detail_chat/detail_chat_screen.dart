import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/messenger/detail_chat_setting/detail_chat_setting_screen.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import 'detail_chat_provider.dart';

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
    provider.init(widget.conversation);
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
            UserProfile user = widget.conversation.secondUser.first;
            return buildScreen(
              isPushLayoutWhenShowKeyboard: true,
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
                CupertinoIcons.phone_fill,
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailChatSettingScreen(
                          conversation: widget.conversation),
                    ),
                  );
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.separated(
        reverse: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemCount: provider.conversation.messages.length,
        itemBuilder: (context, index) {
          var message = provider.conversation.messages[index];
          return buildMessage(message);
        },
      ),
    );
  }

  Widget buildMessage(Message message) {
    return Container(
      alignment: provider.isCurrentUserMessage(message)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: buildTextMessage(message),
    );
  }

  Widget buildTextMessage(Message message) {
    final mWidth = screenWidth();
    final width = message.content.length > mWidth / 7 ? mWidth / 1.3 : null;
    final isCurrentUser = provider.isCurrentUserMessage(message);
    String avataUrl = provider.contactUser.avatar;
    List<Widget> layout = [];
    if (isCurrentUser) {
      layout.addAll(
        [
          Container(
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? Colors.blueAccent
                  : Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: new Text(
                    message.content,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(avataUrl),
          ),
        ],
      );
    } else {
      layout.addAll([
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(avataUrl),
        ),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Colors.blueAccent
                : Color.fromARGB(255, 230, 230, 230),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: new Text(
                  message.content,
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]);
    }
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: layout,
    );
  }

  Widget buidBottom() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 25,
              width: 25,
              child: Icon(
                CupertinoIcons.location_fill,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 25,
              width: 25,
              child: Icon(
                CupertinoIcons.photo_camera_solid,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 25,
              width: 25,
              child: Icon(
                CupertinoIcons.photo_fill,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 25,
              width: 25,
              child: Icon(
                CupertinoIcons.mic_fill,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Aa",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              child: Icon(
                Icons.send,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}

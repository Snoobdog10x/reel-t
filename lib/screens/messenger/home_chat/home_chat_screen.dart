import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import 'package:reel_t/shared_product/assets/icon/tik_tok_icons_icons.dart';
import 'package:reel_t/shared_product/widgets/button/three_row_button.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../screens/messenger/detail_chat/detail_chat_screen.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../new_chat/new_chat_screen.dart';
import 'home_chat_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => HomeChatScreenState();
}

class HomeChatScreenState extends AbstractState<HomeChatScreen> {
  late HomeChatBloc bloc;
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
    bloc = HomeChatBloc();
    bloc.init();
  }

  @override
  void onReady() {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<HomeChatBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            var notLoggedBody = buildLoggedBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Chats",
                appBarAction: GestureDetector(
                  onTap: () {
                    showScreenBottomSheet(Container(
                        height: screenHeight() * 0.8, child: NewChatScreen()));
                  },
                  child: Icon(CupertinoIcons.add_circled, size: 28),
                ),
              ),
              notLoggedBody: notLoggedBody,
              body: body,
              isSafeBottom: false,
              padding: EdgeInsets.symmetric(horizontal: 16),
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
          TikTokIcons.chat_bubble,
          size: 150,
          color: Colors.grey[300],
        ),
        SizedBox(height: 8),
        Text(
          "Chit chat with your friend",
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
              "Login",
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

  Widget buildBody() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      // shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: bloc.conversations.length,
      itemBuilder: ((context, index) {
        var conversations = bloc.conversations;
        var conversation = conversations[index];
        var isDataLoaded = conversation.contactUser.isNotEmpty &&
            conversation.latestMessage.isNotEmpty;
        if (!isDataLoaded) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: buildConversation(
              onTap: () {},
            ),
          );
        }
        ;
        var latestMessage = conversation.latestMessage;
        var user = conversation.contactUser.first;
        return buildConversation(
          avataUrl: user.avatar,
          userName: user.fullName,
          lastedMessage: latestMessage.isEmpty
              ? null
              : Message.fromStringJson(latestMessage),
          onTap: () {
            pushToScreen(DetailChatScreenScreen(conversation: conversation));
          },
        );
      }),
    );
  }

  bool hasSeenMessage(Message? message) {
    if (message == null) return true;
    if (bloc.isCurrentUserMessage(message)) return true;
    return message.hasSeen;
  }

  Widget buildConversation({
    String? avataUrl,
    String? userName,
    Message? lastedMessage,
    required Function onTap,
  }) {
    var hasSeen = hasSeenMessage(lastedMessage);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        // height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            avataUrl != null && avataUrl.isNotEmpty
                ? CircleImage(avataUrl, radius: 60)
                : Container(),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userName ?? "",
                      style: TextStyle(
                        fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                        fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                        fontFamily: SharedTextStyle.DEFAULT_FONT_TITLE,
                      )),
                  SizedBox(height: 3),
                  Text(
                    getContentMessage(lastedMessage),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: SharedTextStyle.NORMAL_SIZE,
                      fontWeight: hasSeen
                          ? SharedTextStyle.NORMAL_WEIGHT
                          : SharedTextStyle.TITLE_WEIGHT,
                      fontFamily: SharedTextStyle.DEFAULT_FONT_TEXT,
                    ),
                  ),
                ],
              ),
            ),
            if (!hasSeen) ...[
              Container(
                height: 10,
                width: 10,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              )
            ]
          ],
        ),
      ),
    );
  }

  String getContentMessage(Message? message) {
    if (message == null) return "";
    if (bloc.isCurrentUserMessage(message)) return "You: ${message.content}";
    return message.content;
  }

  @override
  void onPopWidget() {
    super.onPopWidget();
  }

  @override
  void onDispose() {}
}

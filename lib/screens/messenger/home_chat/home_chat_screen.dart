import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/message/message.dart';
import '../../../models/conversation/conversation.dart';
import '../../../models/user_profile/user_profile.dart';
import '../../../screens/messenger/detail_chat/detail_chat_screen.dart';
import '../../../shared_product/utils/shared_text_style.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
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
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Chat",
                appBarAction: GestureDetector(
                  child: Icon(Icons.chat_outlined, size: 30),
                ),
              ),
              body: body,
              isSafeBottom: false,
              padding: EdgeInsets.symmetric(horizontal: 16),
            );
          },
        );
      },
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
        var hasSeen = conversation.latestMessage.isNotEmpty &&
            conversation.latestMessage.first.hasSeen;
        var user = conversation.contactUser.first;
        return buildConversation(
          avataUrl: user.avatar,
          userName: user.fullName,
          lastedMessage: conversation.latestMessage.isEmpty
              ? null
              : conversation.latestMessage.first,
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

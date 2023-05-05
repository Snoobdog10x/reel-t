import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import 'package:reel_t/shared_product/assets/icon/tik_tok_icons_icons.dart';
import 'package:reel_t/shared_product/widgets/button/three_row_button.dart';
import '../../../screens/messenger/detail_chat/detail_chat_screen.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../new_chat/new_chat_screen.dart';
import 'home_chat_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';
import '../../../shared_product/utils/format/format_utlity.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => HomeChatScreenState();
}

class HomeChatScreenState extends AbstractState<HomeChatScreen>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<HomeChatBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            var notLoggedBody = buildLoggedBody();
            return buildScreen(
              appBar: buildAppBar(),
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

  Widget buildAppBar() {
    return DefaultAppBar(
      appBarTitle: "Chats",
      appBarAction: GestureDetector(
        onTap: () {
          if (appStore.localUser.getCurrentUser().id.isEmpty) return;
          showScreenBottomSheet(
            Container(
              height: screenHeight() * 0.8,
              child: NewChatScreen(
                onCreatedConversation: (conversation, userProfile) {
                  bloc.addedConversation = conversation;
                  bloc.addedUserProfile = userProfile;
                },
              ),
            ),
          );
        },
        child: Icon(CupertinoIcons.add_circled, size: 28),
      ),
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
    var conversations = bloc.conversations.toList();
    return ListView.separated(
      padding: EdgeInsets.zero,
      // shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: conversations.length,
      itemBuilder: ((context, index) {
        var conversation = conversations[index];
        if (!bloc.isLoadData(conversation)) {
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
        var user = bloc.contactUsers[conversation.id]!;
        return buildConversation(
          avataUrl: user.avatar,
          userName: user.fullName,
          lastedMessage: latestMessage.isEmpty
              ? null
              : Message.fromStringJson(latestMessage),
          onTap: () {
            pushToScreen(DetailChatScreenScreen(
              conversation: conversation,
              contactUser: user,
            ));
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
            CircleImage(avataUrl ?? "", radius: 60),
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
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
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
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          " · " + getMessageTime(lastedMessage),
                          style: TextStyle(
                            fontSize: SharedTextStyle.NORMAL_SIZE,
                            fontWeight: hasSeen
                                ? SharedTextStyle.NORMAL_WEIGHT
                                : SharedTextStyle.TITLE_WEIGHT,
                            fontFamily: SharedTextStyle.DEFAULT_FONT_TEXT,
                          ),
                        ),
                      ),
                    ],
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
    if (message == null) return "Send a new message now";
    if (bloc.isCurrentUserMessage(message)) return "You: ${message.content}";
    return message.content;
  }

  String getMessageTime(Message? message) {
    if (message == null) return '';
    var currentDate = DateTime.now();
    var messageCreateAt = DateTime.fromMillisecondsSinceEpoch(message.createAt);
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    if (DateUtils.isSameDay(currentDate, messageCreateAt)) {
      return DateFormat('hh:mm a').format(messageCreateAt);
    }
    if (!FormatUtility.isSameWeek(messageCreateAt, currentDate)) {
      return weekdays[messageCreateAt.weekday.toInt() - 1].toString();
    }
    if (FormatUtility.isSameWeek(messageCreateAt, currentDate)) {
      return "${monthAbbreviations[messageCreateAt.month.toInt() - 1].toString()} ${messageCreateAt.day}";
    }
    return '';
  }

  @override
  void onPopWidget(String previousScreen) {
    super.onPopWidget(previousScreen);
    if (bloc.addedConversation != null && bloc.addedUserProfile != null) {
      pushToScreen(DetailChatScreenScreen(
        conversation: bloc.addedConversation!,
        contactUser: bloc.addedUserProfile!,
      ));
      bloc.addedConversation = null;
      bloc.addedUserProfile = null;
    }
  }

  @override
  void onDispose() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

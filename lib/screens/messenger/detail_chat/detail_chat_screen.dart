import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/message/message.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/messenger/detail_chat_setting/detail_chat_setting_screen.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import 'package:reel_t/shared_product/widgets/image/image_gallery_picker/image_gallery_picker_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../shared_product/widgets/three_row_appbar.dart';
import 'detail_chat_bloc.dart';

class DetailChatScreenScreen extends StatefulWidget {
  final Conversation conversation;
  final UserProfile contactUser;
  final List<Message> messages;
  const DetailChatScreenScreen({
    super.key,
    required this.conversation,
    required this.contactUser,
    this.messages = const [],
  });

  @override
  State<DetailChatScreenScreen> createState() => DetailChatScreenScreenState();
}

class DetailChatScreenScreenState
    extends AbstractState<DetailChatScreenScreen> {
  late DetailChatScreenBloc bloc;
  TextEditingController chatController = TextEditingController();
  late FocusNode chatFocus;
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
    bloc = DetailChatScreenBloc();
    bloc.conversation = widget.conversation;
    bloc.messages.addAll(widget.messages);
    bloc.currentUser = appStore.localUser.getCurrentUser();
    bloc.contactUser = widget.contactUser;
    print(widget.contactUser);
    chatFocus = FocusNode();
    chatFocus.addListener(() {
      notifyDataChanged();
    });
  }

  @override
  void onReady() {
    bloc.sendStreamMessagesEvent(bloc.conversation.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<DetailChatScreenBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            var bottom = buidBottom();
            UserProfile user = bloc.contactUser;
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
                ? CircleImage(
                    avataUrl,
                    radius: 40,
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
      lastWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
                      userProfile: bloc.contactUser,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ),
          SizedBox(width: 8)
        ],
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
        itemCount: bloc.messages.length,
        itemBuilder: (context, index) {
          var message = bloc.messages[index];
          return buildMessage(message);
        },
      ),
    );
  }

  Widget buildMessage(Message message) {
    return Container(
      alignment: bloc.isCurrentUserMessage(message)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: buildTextMessage(message),
    );
  }

  Widget buildTextMessage(Message message) {
    final mWidth = screenWidth();
    final width = message.content.length > mWidth / 7 ? mWidth / 1.3 : null;
    final isCurrentUser = bloc.isCurrentUserMessage(message);
    String avataUrl = bloc.contactUser.avatar;
    List<Widget> layout = [
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
    ];
    if (isCurrentUser) {
      layout.addAll([
        SizedBox(width: 8),
        CircleImage(bloc.currentUser.avatar, radius: 25),
      ]);
    } else {
      layout.insertAll(
        0,
        [CircleImage(avataUrl, radius: 25), SizedBox(width: 8)],
      );
    }
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: layout,
    );
  }

  Widget buidBottom() {
    return Container(
      margin: chatFocus.hasFocus
          ? EdgeInsets.only(bottom: 5, top: 5)
          : EdgeInsets.zero,
      child: Row(
        children: <Widget>[
          if (!chatFocus.hasFocus) ...[
            SizedBox(width: 15),
            buildBottomBarIcon(() {}, CupertinoIcons.photo_camera_solid),
            SizedBox(width: 15),
            buildBottomBarIcon(() {
              showScreenBottomSheet(
                Container(
                  height: screenHeight() * 0.7,
                  child: ImageGalleryPickerScreen(),
                ),
              );
            }, CupertinoIcons.photo_fill),
            SizedBox(width: 15),
            buildBottomBarIcon(() {}, CupertinoIcons.mic_fill),
          ],
          SizedBox(width: 15),
          Expanded(child: buildMessageField()),
          SizedBox(width: 15),
          buildBottomBarIcon(() {
            var messageContent = chatController.text;
            onSubmitMessage(messageContent);
          }, Icons.send, isActive: chatFocus.hasFocus),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget buildMessageField() {
    return TextField(
      controller: chatController,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      focusNode: chatFocus,
      textInputAction: TextInputAction.done,
      onSubmitted: onSubmitMessage,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          hintText: "Aa",
          hintStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusColor: Colors.blueAccent,
          fillColor: Colors.grey[300]!,
          filled: true),
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget buildBottomBarIcon(void Function()? onTap, IconData icon,
      {bool isActive = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        child: Icon(
          icon,
          color: isActive ? Colors.blueAccent : Colors.black,
          size: 30,
        ),
      ),
    );
  }

  void onSubmitMessage(String value) {
    if (chatFocus.hasFocus) chatFocus.unfocus();

    if (value.isEmpty || value.trim().isEmpty) {
      chatController.clear();
      return;
    }
    bloc.sendMessage(value);
    chatController.clear();
  }

  @override
  void onDispose() {
    chatController.clear();
    chatController.dispose();
    chatFocus.dispose();
  }
}

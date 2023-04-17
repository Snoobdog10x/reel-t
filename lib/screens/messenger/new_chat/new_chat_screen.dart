import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../models/conversation/conversation.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import 'new_chat_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class NewChatScreen extends StatefulWidget {
  final void Function(Conversation conversation, UserProfile userProfile)?
      onCreatedConversation;
  const NewChatScreen({super.key, this.onCreatedConversation});

  @override
  State<NewChatScreen> createState() => NewChatScreenState();
}

class NewChatScreenState extends AbstractState<NewChatScreen> {
  late NewChatBloc bloc;
  bool isFocusTextField = false;
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
    bloc = NewChatBloc();
    var currentUserId = appStore.localUser.getCurrentUser().id;
    bloc.sendRetrieveFollowingUserEvent(currentUserId);
    bloc.sendRetrieveConversationUserEvent(currentUserId);
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
        return Consumer<NewChatBloc>(
          builder: (context, value, child) {
            var appBar = buildAppbar();
            var body = buildBody();
            return buildScreen(
                padding: EdgeInsets.symmetric(horizontal: 16),
                appBar: appBar,
                body: body,
                isSafe: false);
          },
        );
      },
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      popTopDisplay();
                    },
                    child: Text('Cancel'),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New Message',
                          style: TextStyle(
                            fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                            fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 2, child: Container())
            ],
          ),
          searchBar(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildBody() {
    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        buildHeaderText("Suggest"),
        SizedBox(height: 16),
        buildNewChatList(bloc.followingUser),
        buildHeaderText("Just talk"),
        SizedBox(height: 16),
        buildNewChatList(bloc.conversationUsers),
      ],
    );
    if (isFocusTextField) body = buildSearchResult();

    return SingleChildScrollView(
      child: body,
    );
  }

  Widget buildSearchResult() {
    return buildNewChatList(bloc.searchUsers);
  }

  Widget buildNewChatList(List<UserProfile> users) {
    List<Widget> layout = [];
    users.forEach((user) {
      layout.addAll([
        userAccount(user.avatar, user.fullName, user.id),
        SizedBox(height: 16)
      ]);
    });
    return Column(
      children: layout,
    );
  }

  Widget buildHeaderText(String content) {
    return Text(
      content,
      style: TextStyle(
        color: Colors.black,
        fontSize: SharedTextStyle.SUB_TITLE_SIZE,
      ),
    );
  }

  Widget userAccount(String avatar, String fullName, String userId) {
    return GestureDetector(
      onTap: () {
        bloc.sendCreateConversation(userId);
      },
      child: Row(
        children: [
          CircleImage(
            avatar,
            radius: 40,
          ),
          SizedBox(width: 8),
          Expanded(child: Text(fullName))
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              onTapOutside: (PointerDownEvent) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  isFocusTextField = false;
                  notifyDataChanged();
                  return;
                }
                bloc.sendSearchUserEvent(value);
                isFocusTextField = true;
                notifyDataChanged();
              },
              textInputAction: TextInputAction.search,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  width: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}

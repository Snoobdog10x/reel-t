import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import 'home_chat_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends AbstractState<HomeChatScreen> {
  late HomeChatProvider provider;
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
    provider = HomeChatProvider();
    provider.init();
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
        return Consumer<HomeChatProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
                appBar: DefaultAppBar(
                    appBarTitle: "Chat",
                    appBarAction: GestureDetector(
                      child: Icon(Icons.chat_outlined, size: 30),
                    )),
                body: body,
                padding: EdgeInsets.symmetric(horizontal: 16));
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: provider.conversations.length,
            itemBuilder: ((context, index) {
              var conv = provider.conversations[index.toString()];
              UserProfile user = conv![provider.USER_KEY] as UserProfile;
              return buildConversation(
                  avataUrl: user.avatar, userName: user.fullName);
            }),
          ),
        )
      ],
    );
  }

  Widget buildConversation({
    String? avataUrl,
    String? userName,
    String? lastedMessage,
  }) {
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          avataUrl != null
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      avataUrl,
                    ),
                    radius: 40,
                  ),
                )
              : Container(),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName ?? "",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    lastedMessage ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ],
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

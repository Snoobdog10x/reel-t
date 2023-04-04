import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/conversation/conversation.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/screens/messenger/detail_chat/detail_chat_screen.dart';
import 'package:shimmer/shimmer.dart';
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
  void onReady() {}

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
      itemCount: provider.conversations.values.length,
      itemBuilder: ((context, index) {
        var conversations = provider.conversations.values.toList();
        var conversation = conversations[index];
        var isDataLoaded = conversation.secondUser.isNotEmpty;
        var user = isDataLoaded ? conversation.secondUser.first : UserProfile();
        if (!isDataLoaded) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: buildConversation(
              avataUrl: user.avatar,
              userName: user.fullName,
              onTap: () {
                pushToScreen(
                    DetailChatScreenScreen(conversation: conversation));
              },
            ),
          );
        }
        return buildConversation(
          avataUrl: user.avatar,
          userName: user.fullName,
          onTap: () {
            pushToScreen(DetailChatScreenScreen(conversation: conversation));
          },
        );
      }),
    );
  }

  Widget buildConversation({
    String? avataUrl,
    String? userName,
    String? lastedMessage,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        // height: 70,
        child: Row(
          children: <Widget>[
            avataUrl != null
                ? CachedNetworkImage(
                    height: 60,
                    width: 60,
                    imageUrl: avataUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Container();
                    },
                  )
                : Container(),
            SizedBox(width: 8),
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
                      lastedMessage ?? "You have a new message",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onPopWidget() {
    // TODO: implement onPopWidget
    super.onPopWidget();
    print("object");
  }

  @override
  void onDispose() {
    // appStore.localMessenger.saveConversations(provider.conversations);
  }
}

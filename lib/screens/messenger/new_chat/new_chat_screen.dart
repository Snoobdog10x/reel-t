import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/image/circle_image.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import 'new_chat_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => NewChatScreenState();
}

class NewChatScreenState extends AbstractState<NewChatScreen> {
  late NewChatBloc bloc;
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
    bloc.sendRetrieveFollowingUserEvent(appStore.localUser.getCurrentUser().id);
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
          Container(
              //Search bar
              ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: bloc.user.length,
      itemBuilder: (context, index) {
        var user = bloc.user[index];
        return userAccount(user.avatar, user.fullName);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16,
        );
      },
    );
  }

  Widget userAccount(String avatar, String fullName) {
    return Row(
      children: [
        CircleImage(
          avatar,
          radius: 40,
        ),
        SizedBox(width: 8),
        Expanded(child: Text(fullName))
      ],
    );
  }

  @override
  void onDispose() {}
}

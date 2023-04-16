import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/user/login/login_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/utils/text/shared_text_style.dart';
import '../../../shared_product/widgets/image/circle_image.dart';
import 'switch_account_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({super.key});

  @override
  State<SwitchAccountScreen> createState() => SwitchAccountScreenState();
}

class SwitchAccountScreenState extends AbstractState<SwitchAccountScreen> {
  late SwitchAccountBloc bloc;
  double ACCOUNT_ITEM_HEIGHT = 50;
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
    bloc = SwitchAccountBloc();
    bloc.init();
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
        return Consumer<SwitchAccountBloc>(
          builder: (context, value, child) {
            var appBar = buildAppbar();
            var body = buildBody();
            return buildScreen(
              padding: EdgeInsets.symmetric(horizontal: 8),
              background: Colors.white,
              isSafe: true,
              isSafeTop: false,
              isWrapBody: true,
              appBar: appBar,
              body: body,
            );
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
                child: Container(),
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
                          'Switch Account',
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
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      popTopDisplay();
                    },
                    child: Icon(CupertinoIcons.xmark),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    var layout = bloc.switchAccounts
        .map(
          (user) => userAccount(user.avatar, user.fullName, false),
        )
        .toList();

    layout.insert(0,
        userAccount(bloc.currentUser.avatar, bloc.currentUser.userName, true));
    layout.add(
      userAccount(
        "",
        "add account",
        false,
        onTap: () {
          pushToScreen(LoginScreen());
        },
      ),
    );

    return Column(children: layout);
  }

  Widget userAccount(String avatar, String fullName, bool isCheck,
      {Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 8),
        height: ACCOUNT_ITEM_HEIGHT,
        width: screenWidth(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CircleImage(
                avatar,
                radius: 50,
                background: Color.fromARGB(255, 240, 240, 240),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(fullName),
            ),
            Expanded(
              flex: 2,
              child: isCheck
                  ? Icon(
                      CupertinoIcons.check_mark,
                      color: Colors.red,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onDispose() {}
}

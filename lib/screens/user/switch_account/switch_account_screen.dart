import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              isSafe: false,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: 1,
            itemBuilder: (context, index) {
              var user = appStore.localUser.getCurrentUser();
              return userAccount(user.avatar, user.fullName, true);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16,
              );
            },
          ),
        ),
        userAccount('', 'Add account', false),
        SizedBox(height: 8),
      ],
    );
  }

  Widget userAccount(String avatar, String fullName, bool isCheck) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CircleImage(
              avatar,
              radius: 50,
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
    );
  }

  @override
  void onDispose() {}
}

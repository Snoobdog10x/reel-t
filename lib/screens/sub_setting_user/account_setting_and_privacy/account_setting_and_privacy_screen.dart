import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../reset_password/reset_password_screen.dart';
import 'account_setting_and_privacy_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class AccountSettingAndPrivacyScreen extends StatefulWidget {
  const AccountSettingAndPrivacyScreen({super.key});

  @override
  State<AccountSettingAndPrivacyScreen> createState() =>
      AccountSettingAndPrivacyScreenState();
}

class AccountSettingAndPrivacyScreenState
    extends AbstractState<AccountSettingAndPrivacyScreen> {
  late AccountSettingAndPrivacyBloc bloc;
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
    bloc = AccountSettingAndPrivacyBloc();
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
        return Consumer<AccountSettingAndPrivacyBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Account",
                onTapBackButton: () {
                  popTopDisplay();
                },
              ),
              padding: EdgeInsets.only(left: 16, right: 16),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [buildAccount()],
    );
  }

  Widget buildAccount() {
    return Container(
      height: screenHeight() * 0.34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color.fromARGB(255, 248, 249, 249),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: buildOptionItem(
                        'User Information',
                        () {
                          // pushToScreen();
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: buildOptionItem(
                        'Password',
                        () {
                          pushToScreen(ResetPasswordScreen());
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: buildOptionItem('Switch to Business Account',
                          () {}, true, Color.fromARGB(255, 160, 160, 160)),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Container(
                          width: screenWidth(),
                          height: screenHeight(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: screenHeight(),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Download your data',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Get a copy of your REEL T data',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 160, 160, 160),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Icon(
                                CupertinoIcons.forward,
                                size: 20,
                                color: Color.fromARGB(255, 160, 160, 160),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: buildOptionItem(
                        'Deactivate or delete account',
                        () {},
                        false,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionItem(
      String optionTitle, Function onTapAction, bool isDivide, Color colors) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Container(
        width: screenWidth(),
        height: screenHeight(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                height: screenHeight(),
                decoration: isDivide
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.05,
                          ),
                        ),
                      )
                    : null,
                child: Text(
                  optionTitle,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.forward,
              size: 20,
              color: Color.fromARGB(255, 160, 160, 160),
            ),
          ],
        ),
      ),
      onPressed: () {
        onTapAction();
      },
    );
  }

  @override
  void onDispose() {}
}

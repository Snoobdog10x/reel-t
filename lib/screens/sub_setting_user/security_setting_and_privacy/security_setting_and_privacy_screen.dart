import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'security_setting_and_privacy_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class SecuritySettingAndPrivacyScreen extends StatefulWidget {
  const SecuritySettingAndPrivacyScreen({super.key});

  @override
  State<SecuritySettingAndPrivacyScreen> createState() =>
      SecuritySettingAndPrivacyScreenState();
}

class SecuritySettingAndPrivacyScreenState
    extends AbstractState<SecuritySettingAndPrivacyScreen> {
  late SecuritySettingAndPrivacyBloc bloc;
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
    bloc = SecuritySettingAndPrivacyBloc();
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
        return Consumer<SecuritySettingAndPrivacyBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Security",
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
      children: [buildSecurity()],
    );
  }

  Widget buildSecurity() {
    return Container(
      height: screenHeight() * 0.3,
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
                      child: buildOptionItem(
                        'Security alerts',
                        () {
                          // pushToScreen();
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Manage devices',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        'Manage app permissions',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
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
                                        '2-step verification',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '2-step verification offers an extra layer of security for your account, even if someone knows your password.',
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

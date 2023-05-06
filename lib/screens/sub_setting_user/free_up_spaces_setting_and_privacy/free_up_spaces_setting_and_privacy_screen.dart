import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'free_up_spaces_setting_and_privacy_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class FreeUpSpacesSettingAndPrivacyScreen extends StatefulWidget {
  const FreeUpSpacesSettingAndPrivacyScreen({super.key});

  @override
  State<FreeUpSpacesSettingAndPrivacyScreen> createState() =>
      FreeUpSpacesSettingAndPrivacyScreenState();
}

class FreeUpSpacesSettingAndPrivacyScreenState
    extends AbstractState<FreeUpSpacesSettingAndPrivacyScreen> {
  late FreeUpSpacesSettingAndPrivacyBloc bloc;
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
    bloc = FreeUpSpacesSettingAndPrivacyBloc();
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
        return Consumer<FreeUpSpacesSettingAndPrivacyBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Pree up space",
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
      children: [
        Container(
          height: screenHeight() * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Color.fromARGB(255, 248, 249, 249),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: buildOptionItem(
                              'Cache',
                              '93.7MB',
                              'Clear your cache free up space. This won\'t affect your REEL T experiment',
                              () {},
                              true),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          flex: 2,
                          child: buildOptionItem(
                              'Downloads',
                              '27.6MB',
                              'Downloads may include effects, filters, stickers, and virtual gifts downloaded in your application app. You\'ll be able to download them again if you need them.',
                              () {},
                              false),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOptionItem(String title, String value, String description,
      Function onTapAction, bool isDivide) {
    return Container(
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
                          width: 0.08,
                        ),
                      ),
                    )
                  : null,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          title + ': ' + value,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                            onPressed: () {
                              onTapAction();
                            },
                            child: Text(
                              'Clear',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 160, 160, 160),
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

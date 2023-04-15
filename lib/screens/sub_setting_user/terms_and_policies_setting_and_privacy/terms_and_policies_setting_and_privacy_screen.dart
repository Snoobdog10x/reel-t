import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'terms_and_policies_setting_and_privacy_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class TermsAndPoliciesSettingAndPrivacyScreen extends StatefulWidget {
  const TermsAndPoliciesSettingAndPrivacyScreen({super.key});

  @override
  State<TermsAndPoliciesSettingAndPrivacyScreen> createState() =>
      TermsAndPoliciesSettingAndPrivacyScreenState();
}

class TermsAndPoliciesSettingAndPrivacyScreenState
    extends AbstractState<TermsAndPoliciesSettingAndPrivacyScreen> {
  late TermsAndPoliciesSettingAndPrivacyBloc bloc;
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
    bloc = TermsAndPoliciesSettingAndPrivacyBloc();
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
        return Consumer<TermsAndPoliciesSettingAndPrivacyBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Terms and Policies",
                onTapBackButton: () {
                  popTopDisplay();
                },
              ),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [buildTermsAndPolicies()],
    );
  }

  Widget buildTermsAndPolicies() {
    return Container(
      height: screenHeight() * 0.24,
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
                        Icons.topic,
                        'Community Guidelines',
                        () {
                          // pushToScreen();
                        },
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        Icons.library_books,
                        'Terms of Service',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        Icons.description,
                        'Privacy Policy',
                        () {},
                        true,
                        Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                    Expanded(
                      child: buildOptionItem(
                        Icons.copyright,
                        'Copyright Policy',
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

  Widget buildOptionItem(IconData icon, String optionTitle,
      Function onTapAction, bool isDivide, Color colors) {
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
            Icon(
              icon,
              size: 20,
              color: colors,
            ),
            SizedBox(width: 16),
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

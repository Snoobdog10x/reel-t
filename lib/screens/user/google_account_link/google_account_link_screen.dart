import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/button/three_row_button.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';
import 'google_account_link_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class GoogleAccountLinkScreen extends StatefulWidget {
  final GoogleSignInAccount googleSignInAccount;
  const GoogleAccountLinkScreen({super.key, required this.googleSignInAccount});

  @override
  State<GoogleAccountLinkScreen> createState() =>
      GoogleAccountLinkScreenState();
}

class GoogleAccountLinkScreenState
    extends AbstractState<GoogleAccountLinkScreen> {
  late GoogleAccountLinkBloc bloc;
  static String SIGN_UP_SCREEN = "sign_up_screen";
  TextEditingController passwordController = TextEditingController();
  bool isValidPassword = false;
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
    bloc = GoogleAccountLinkBloc();
    bloc.init(widget.googleSignInAccount);
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
        return Consumer<GoogleAccountLinkBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Linking Google",
                onTapBackButton: () => popTopDisplay(),
              ),
              body: body,
              padding: EdgeInsets.symmetric(horizontal: 16),
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 17,
          child: Column(
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildSignInFields(),
              SizedBox(height: 8 * 4),
              buildButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTitle() {
    return Container(
      width: screenWidth(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Link Google",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
              "Please Enter your account password to complete link account with google."),
        ],
      ),
    );
  }

  Widget buildSignInFields() {
    return Container(
      width: screenWidth(),
      child: Column(
        children: [
          SizedBox(height: 8),
          CustomTextField(
            controller: passwordController,
            hintText: "Password",
            isPasswordField: true,
            onTextChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      width: screenWidth(),
      child: Column(
        children: [
          SizedBox(height: 8),
          ThreeRowButton(
            onTap: () {
              startLoading();
              bloc.authenticate(passwordController.text);
            },
            color: Colors.green,
            title: Text(
              "Link Google",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/signup/signup_provider.dart';
import 'package:reel_t/shared_product/widgets/button/three_row_button.dart';
import 'package:reel_t/shared_product/widgets/text_field/custom_text_field.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends AbstractState<SignupScreen> {
  late SignupProvider provider;
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
    provider = SignupProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<SignupProvider>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                appBarTitle: "Sign-up",
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
        SizedBox(height: 8 * 7),
        buildTitle(),
        SizedBox(height: 8),
        buildSignInFields(),
        SizedBox(height: 8 * 6),
        buildButtons(),
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
            "Create Account",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text("Enter your Name, Email, and Password for sign up."),
          GestureDetector(
            onTap: () {
              popTopDisplay();
            },
            child: Text(
              "Already have account?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInFields() {
    return Container(
      width: screenWidth(),
      child: Column(
        children: [
          CustomTextField(
            hintText: "Name",
            onTextChanged: (value) {
              provider.name = value;
            },
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Email",
            onTextChanged: (value) {
              provider.email = value;
            },
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Password",
            isPasswordField: true,
            onTextChanged: (value) {
              provider.password = value;
            },
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
          ThreeRowButton(
            onTap: () {
              startLoading();
              provider.signIn();
            },
            title: Text(
              "SIGN IN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: screenWidth() * 0.6,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    "By Signing up you agree to our Terms Conditions & Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Or",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 8),
          ThreeRowButton(
            color: Colors.blueAccent,
            prefixIcon: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Image.asset(
                "lib/shared_product/assets/icon/google_icon.png",
              ),
            ),
            title: Text(
              "CONNECT WITH GOOGLE",
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

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

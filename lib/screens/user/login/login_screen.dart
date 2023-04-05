import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'login_bloc.dart';
import '../signup/signup_screen.dart';
import '../../../shared_product/widgets/default_appbar.dart';

import '../../../shared_product/widgets/button/three_row_button.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends AbstractState<LoginScreen> {
  late LoginBloc bloc;
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
    bloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<LoginBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                onTapBackButton: () => popTopDisplay(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
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
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              buildTitle(),
              SizedBox(height: 16),
              buildLoginFields(),
              SizedBox(height: 8 * 6),
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
            "Welcome",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text("Enter your Email, and Password to login."),
        ],
      ),
    );
  }

  Widget buildLoginFields() {
    return Container(
      width: screenWidth(),
      child: Column(
        children: [
          CustomTextField(
            hintText: "Email",
            onTextChanged: (value) {
              bloc.email = value;
            },
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Password",
            isPasswordField: true,
            onTextChanged: (value) {
              bloc.password = value;
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
              bloc.login();
            },
            title: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't have account?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: " Create account",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                ),
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

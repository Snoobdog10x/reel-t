import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../signup/signup_bloc.dart';
import '../../../shared_product/widgets/button/three_row_button.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends AbstractState<SignupScreen> {
  late SignupBloc bloc;
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
    bloc = SignupBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<SignupBloc>(
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
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Email",
            onTextChanged: (value) {
              bloc.email = value;
            },
          ),
          SizedBox(height: 8),
          CustomTextField(
            controller: passwordController,
            hintText: "Password",
            isPasswordField: true,
            onTextChanged: (value) {
              bloc.password = value;
            },
          ),
          SizedBox(height: 8),
          FlutterPwValidator(
            controller: passwordController,
            minLength: 8,
            uppercaseCharCount: 1,
            numericCharCount: 3,
            width: 400,
            height: 150,
            onSuccess: () {
              isValidPassword = true;
              notifyDataChanged();
            },
            onFail: () {
              isValidPassword = false;
              notifyDataChanged();
            },
          )
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
              if (!isValidPassword) {
                return;
              }
              bloc.signIn();
            },
            color: isValidPassword ? Colors.green : Colors.grey[500]!,
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
            onTap: () {
              bloc.sendGoogleSignUpEvent();
              startLoading();
            },
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
  void onPopWidget() {
    // TODO: implement onPopWidget
    super.onPopWidget();
    popTopDisplay();
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

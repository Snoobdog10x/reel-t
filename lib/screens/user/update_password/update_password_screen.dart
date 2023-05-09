import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/navigation/navigation_screen.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/button/three_row_button.dart';
import '../../../shared_product/widgets/text_field/custom_text_field.dart';
import 'update_password_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => UpdatePasswordScreenState();
}

class UpdatePasswordScreenState extends AbstractState<UpdatePasswordScreen> {
  late UpdatePasswordBloc bloc;
  TextEditingController textEditingController = TextEditingController();
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
    bloc = UpdatePasswordBloc();
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
        return Consumer<UpdatePasswordBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              padding: EdgeInsets.symmetric(horizontal: 16),
              appBar: DefaultAppBar(
                appBarTitle: "Update Password",
                onTapBackButton: () {
                  pushToScreen(NavigationScreen(), isReplace: true);
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
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              buildTitle(),
              SizedBox(height: 16),
              buildLoginFields(),
              SizedBox(height: 8 * 4),
              ThreeRowButton(
                onTap: () {
                  startLoading();
                  bloc.sendUpdatePassword();
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
            "Update Password",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text("Enter your new password"),
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
            controller: textEditingController,
            hintText: "New Password",
            isPasswordField: true,
            onTextChanged: (value) {
              bloc.newPassword = value;
              notifyDataChanged();
            },
          ),
          SizedBox(height: 8),
          CustomTextField(
            hintText: "Confirm Password",
            isPasswordField: true,
            onTextChanged: (value) {
              bloc.confirmPassword = value;
              notifyDataChanged();
            },
          ),
          SizedBox(height: 8),
          FlutterPwValidator(
            controller: textEditingController,
            minLength: 8,
            uppercaseCharCount: 1,
            numericCharCount: 3,
            width: 400,
            height: 150,
            onSuccess: () {
              bloc.isValidPassword = true;
              notifyDataChanged();
            },
            onFail: () {
              bloc.isValidPassword = false;
              notifyDataChanged();
            },
          )
        ],
      ),
    );
  }

  @override
  void onPopWidget(String previousScreen) {
    // TODO: implement onPopWidget
    super.onPopWidget(previousScreen);
    if (previousScreen != ALERT_DIALOG_WIDGET)
      pushToScreen(NavigationScreen(), isReplace: true);
  }

  @override
  void onDispose() {}
}

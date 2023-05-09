import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/sub_setting_user/reset_password/reset_password_bloc.dart';
import 'package:reel_t/shared_product/widgets/button/three_row_button.dart';
import 'package:reel_t/shared_product/widgets/text_field/custom_text_field.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends AbstractState<ResetPasswordScreen> {
  late TextEditingController _controllerPassword = TextEditingController();
  late TextEditingController _controllerEmail = TextEditingController();
  late ResetPasswordBloc bloc;
  static final RESET_PASSWORD_SCREEN = "reset_password_screen";
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
    bloc = ResetPasswordBloc();
    bloc.init();
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
        return Consumer<ResetPasswordBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              padding: EdgeInsets.symmetric(horizontal: 14),
              appBar: DefaultAppBar(
                appBarTitle: "Reset Password",
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reset Password',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            'You must provide your current password first, then a otp email will be sent to you',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          CustomTextField(
            isPasswordField: true,
            hintText: "Your current password",
            onTextChanged: (value) {
              bloc.currentPassword = value;
            },
          ),
          SizedBox(height: 16),
          ThreeRowButton(
            title: Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              bloc.verifyPassword();
            },
          )
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}

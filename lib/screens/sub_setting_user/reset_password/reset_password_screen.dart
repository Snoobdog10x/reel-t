import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/sub_setting_user/reset_password/reset_password_bloc.dart';
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
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Please enter your old password',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          TextField(
            controller: _controllerPassword,
            maxLength: 30,
            decoration: InputDecoration(
              counterText: "",
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  _controllerPassword.clear();
                  notifyDataChanged();
                },
                icon: Icon(CupertinoIcons.xmark_circle),
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Please enter your email address',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          TextField(
            controller: _controllerEmail,
            maxLength: 30,
            decoration: InputDecoration(
              counterText: "",
              hintText: "Email",
              suffixIcon: IconButton(
                onPressed: () {
                  _controllerEmail.clear();
                  notifyDataChanged();
                },
                icon: Icon(CupertinoIcons.xmark_circle),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  @override
  void onDispose() {}
}

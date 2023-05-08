import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'email_authenticate_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class EmailAuthenticateScreen extends StatefulWidget {
  final String email;
  final String password;
  final String previousScreen;
  const EmailAuthenticateScreen(
      {super.key,
      required this.email,
      this.password = "",
      this.previousScreen = ""});

  @override
  State<EmailAuthenticateScreen> createState() =>
      EmailAuthenticateScreenState();
}

class EmailAuthenticateScreenState
    extends AbstractState<EmailAuthenticateScreen> {
  late EmailAuthenticateBloc bloc;
  Timer? resendTimer;
  int resendSecond = 30;
  late OtpFieldController controller = OtpFieldController();
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
    bloc = EmailAuthenticateBloc();
    bloc.email = widget.email;
    bloc.password = widget.password;
    startCountDown();
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    controller.setFocus(0);
  }

  @override
  void onReady() {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<EmailAuthenticateBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(
                onTapBackButton: () {
                  popTopDisplay();
                },
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
        SizedBox(height: 32),
        buildTitle(),
        SizedBox(height: 16),
        OTPTextField(
          controller: controller,
          length: 5,
          spaceBetween: 25,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 50,
          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          otpFieldStyle: OtpFieldStyle(focusBorderColor: Colors.green),
          onCompleted: (value) {
            bloc.verifyOTP(value);
          },
          onChanged: (value) {},
        ),
        SizedBox(height: 8),
        buildResend()
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
            "Verification code",
            style: TextStyle(
                color: Colors.black,
                fontSize: SharedTextStyle.LARGE_TITLE_SIZE,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT),
          ),
          SizedBox(height: 4),
          Text("We have sent the OTP code to"),
          SizedBox(height: 4),
          buildRichChangeEmail(),
        ],
      ),
    );
  }

  Widget buildRichChangeEmail() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        text: '${bloc.email} ',
        children: <TextSpan>[
          TextSpan(
            text: 'Change email?',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                popTopDisplay();
              },
          ),
        ],
      ),
    );
  }

  Widget buildResend() {
    bool isResendCode = resendSecond == 0;
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        text: 'Resend code after ',
        children: <TextSpan>[
          TextSpan(
            text: isResendCode
                ? "Resend"
                : bloc.convertSecondToMinute(resendSecond),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (isResendCode) {
                  bloc.resendOTP();
                  resendSecond = 30;
                  notifyDataChanged();
                  startCountDown();
                }
              },
          ),
        ],
      ),
    );
  }

  void startCountDown() {
    resendTimer?.cancel();
    resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendSecond > 0) {
        resendSecond--;
        notifyDataChanged();
        return;
      }

      if (resendSecond == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onDispose() {
    resendTimer?.cancel();
  }
}

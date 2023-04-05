import 'dart:async';

import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import '../../../generated/abstract_bloc.dart';
import 'email_authenticate_screen.dart';

class EmailAuthenticateBloc extends AbstractBloc<EmailAuthenticateScreenState>
    with SendEmailOtpEvent {
  String email = "Duythanh1565@gmail.com";

  void init() {}
  void verifyOTP(String otp) {
    var isValid = appStore.emailAuth.verifyOTP(otp);
    if (isValid) {
      state.popTopDisplay();
      return;
    }
    state.showAlertDialog(
      title: "OTP Verification",
      content: "Wrong OTP, please try again",
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  String convertSecondToMinute(int second) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    var min = second ~/ 60;
    var sec = second % 60;
    return "${twoDigits(min)}:${twoDigits(sec)}";
  }

  @override
  void onSendEmailOtpEventDone(bool isSent) {
    // TODO: implement onSendEmailOtpEventDone
  }
}

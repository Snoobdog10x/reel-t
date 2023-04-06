import 'dart:async';

import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'email_authenticate_screen.dart';

class EmailAuthenticateBloc extends AbstractBloc<EmailAuthenticateScreenState>
    with SendEmailOtpEvent {
  late UserProfile signInUserProfile;
  void resendOTP() {
    sendSendEmailOtpEvent(signInUserProfile.email);
  }

  void verifyOTP(String otp) {
    var isValid = appStore.emailAuth.verifyOTP(otp);
    if (isValid) {
      appStore.emailAuth.removeOTP();
      appStore.localUser.login(signInUserProfile);
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
    if (isSent) {
      notifyDataChanged();
      return;
    }
    state.showAlertDialog(
      title: "OTP Verification",
      content: "Server error, please try after 15 minute",
      confirm: () {
        state.popTopDisplay();
      },
    );
  }
}

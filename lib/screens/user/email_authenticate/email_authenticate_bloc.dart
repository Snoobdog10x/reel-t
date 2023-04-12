import 'dart:async';

import 'package:reel_t/events/user/send_email_otp/send_email_otp_event.dart';
import 'package:reel_t/events/user/user_sign_up/user_sign_up_event.dart';
import 'package:reel_t/events/user/verify_email_otp/verify_email_otp_event.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../models/user_profile/user_profile.dart';
import 'email_authenticate_screen.dart';

class EmailAuthenticateBloc extends AbstractBloc<EmailAuthenticateScreenState>
    with SendEmailOtpEvent, VerifyEmailOtpEvent, UserSignUpEvent {
  String email = "";
  void resendOTP() {
    sendSendEmailOtpEvent(email);
  }

  void verifyOTP(String otp) {
    state.startLoading();
    sendVerifyEmailOtpEvent(email, otp);
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

  @override
  void onVerifyEmailOtpEventDone(bool isVerified, String verifyStatus) {
    state.stopLoading();
    if (isVerified) {
      // appStore.localUser.login(signInUserProfile);
      state.popTopDisplay();
      return;
    }

    state.showAlertDialog(
      title: "OTP Verification",
      content: verifyStatus,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }

  @override
  void onUserSignUpEventDone(String errorMessage, UserProfile? signedUser) {
    state.stopLoading();
    if (errorMessage.isEmpty) {
      return;
    }

    state.showAlertDialog(
      title: "Sign-up",
      content: errorMessage,
      confirm: () {
        state.popTopDisplay();
      },
    );
  }
}

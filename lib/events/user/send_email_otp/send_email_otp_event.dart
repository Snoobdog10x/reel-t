import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/email_otp/email_otp.dart';

import '../../../generated/app_init.dart';

abstract class SendEmailOtpEvent {
  final _appStore = AppInit.appStore;
  final _db = FirebaseFirestore.instance.collection(EmailOtp.PATH);
  Future<void> sendSendEmailOtpEvent(String email) async {
    try {
      var OTP = _appStore.emailAuth.generateOTP();
      var id = _db.doc().id;
      var now = DateTime.now();
      var emailLowerCase = email.toLowerCase();
      var emailOTPJson = EmailOtp(
        id: id,
        otpCode: OTP,
        verifyEmail: emailLowerCase,
        isVerify: false,
        createAt: now.millisecondsSinceEpoch,
        expireAt: now.add(Duration(minutes: 5)).millisecondsSinceEpoch,
      ).toJson();
      await _db.doc(id).set(emailOTPJson);
      var isSent = await _appStore.emailAuth.sendOTP(emailLowerCase);
      onSendEmailOtpEventDone(isSent);
    } catch (e) {
      onSendEmailOtpEventDone(false);
    }
  }

  void onSendEmailOtpEventDone(bool isSent);
}

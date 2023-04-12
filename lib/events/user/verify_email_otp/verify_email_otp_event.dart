import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/email_otp/email_otp.dart';

import '../../../shared_product/utils/format/format_utlity.dart';

abstract class VerifyEmailOtpEvent {
  final _db = FirebaseFirestore.instance.collection(EmailOtp.PATH);
  Future<void> sendVerifyEmailOtpEvent(String email, String otp) async {
    try {
      var emailOtp = await verifyEmailOtp(otp, email);
      if (emailOtp == null) {
        onVerifyEmailOtpEventDone(
            false, "OTP code is invalid, please try again");
        return;
      }

      if (emailOtp.expireAt < FormatUtility.getMillisecondsSinceEpoch()) {
        onVerifyEmailOtpEventDone(
            false, "OTP code is expired, please resend its");
        return;
      }
      updateEmailOpt(emailOtp);
      return onVerifyEmailOtpEventDone(true, "Success");
    } catch (e) {
      print(e);
      onVerifyEmailOtpEventDone(
          false, "Server is upgrade, please retry after 15 minutes");
    }
  }

  Future<EmailOtp?> verifyEmailOtp(String otp, String email) async {
    var query = _db
        .where(EmailOtp.verifyEmail_PATH, isEqualTo: email)
        .where(EmailOtp.otpCode_PATH, isEqualTo: otp)
        .where(EmailOtp.isVerify_PATH, isEqualTo: false);
    var snapshot = await query.get();
    if (snapshot.docs.isEmpty) return null;
    return EmailOtp.fromJson(snapshot.docs.first.data());
  }

  Future<void> updateEmailOpt(EmailOtp emailOtp) async {
    emailOtp.isVerify = true;
    emailOtp.expireAt = FormatUtility.getMillisecondsSinceEpoch();
    await _db.doc(emailOtp.id).set(emailOtp.toJson());
  }

  void onVerifyEmailOtpEventDone(bool isVerified, String verifyStatus);
}

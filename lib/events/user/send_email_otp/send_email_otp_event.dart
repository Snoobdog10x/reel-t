import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:reel_t/models/email_otp/email_otp.dart';

import '../../../generated/app_init.dart';

abstract class SendEmailOtpEvent {
  final _appStore = AppInit.appStore;
  final _db = FirebaseFirestore.instance.collection(EmailOtp.PATH);
  final _function = FirebaseFunctions.instance;
  Future<void> sendSendEmailOtpEvent(String email) async {
    try {
      HttpsCallable callable = _function.httpsCallable("emailOtpGenerate");
      var result = await callable.call(email);
      onSendEmailOtpEventDone(true);
    } catch (e) {
      print(e);
      onSendEmailOtpEventDone(false);
    }
  }

  void onSendEmailOtpEventDone(bool isSent);
}

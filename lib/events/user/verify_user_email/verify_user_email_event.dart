import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/generated/app_init.dart';
import 'package:reel_t/shared_product/services/email_authentication.dart';

import '../user_sign_up/user_sign_up_event.dart';

abstract class VerifyUserEmailEvent {
  var _appStore = AppInit.appStore;
  Future<void> sendVerifyUserEmailEvent(String email) async {
    try {
      print("sendOTP");
      var isSent = await _appStore.emailAuth.sendOTP(email);
      print(isSent);
      onVerifyUserEmailEventDone(isSent.toString());
    } catch (e) {
      onVerifyUserEmailEventDone(false.toString());
    }
  }

  void onVerifyUserEmailEventDone(String e);
}

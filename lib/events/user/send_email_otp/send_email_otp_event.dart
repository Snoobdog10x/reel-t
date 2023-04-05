import '../../../generated/app_init.dart';

abstract class SendEmailOtpEvent {
  var _appStore = AppInit.appStore;
  Future<void> sendSendEmailOtpEvent(String email) async {
    try {
      var isSent = await _appStore.emailAuth.sendOTP(email);
      onSendEmailOtpEventDone(isSent);
    } catch (e) {
      onSendEmailOtpEventDone(false);
    }
  }

  void onSendEmailOtpEventDone(bool isSent);
}

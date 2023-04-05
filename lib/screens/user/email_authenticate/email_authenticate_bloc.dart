import 'dart:async';

import '../../../events/user/verify_user_email/verify_user_email_event.dart';
import '../../../generated/abstract_bloc.dart';
import 'email_authenticate_screen.dart';

class EmailAuthenticateBloc extends AbstractBloc<EmailAuthenticateScreenState>
    with VerifyUserEmailEvent {
  String email = "Duythanh1565@gmail.com";

  void init() {}


  @override
  void onVerifyUserEmailEventDone(String e) {
    // TODO: implement onVerifyUserEmailEventDone
  }

  String convertSecondToMinute(int second) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    var min = second ~/ 60;
    var sec = second % 60;
    return "${twoDigits(min)}:${twoDigits(sec)}";
  }
}

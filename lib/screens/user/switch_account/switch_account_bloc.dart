import 'package:firebase_auth/firebase_auth.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../../generated/abstract_bloc.dart';
import 'switch_account_screen.dart';

class SwitchAccountBloc extends AbstractBloc<SwitchAccountScreenState> {
  List<UserProfile> switchAccounts = [];
  late UserProfile currentUser;
  void init() {
    currentUser = appStore.localUser.getCurrentUser();
    switchAccounts = appStore.localUser.getSwitchAccounts();
    notifyDataChanged();
  }
}

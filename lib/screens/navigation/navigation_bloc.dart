import 'package:reel_t/models/user_profile/user_profile.dart';

import '../../generated/abstract_bloc.dart';
import 'navigation_screen.dart';

class NavigationBloc extends AbstractBloc<NavigationScreenState> {
  late UserProfile currentUser;
  void init() {
    
  }
  
}

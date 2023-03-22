import 'package:flutter/material.dart';
import '../../shared_product/first_init.dart';
import '../../shared_product/services/app_store.dart';
import 'abstract_state.dart';

abstract class AbstractProvider extends ChangeNotifier {
  late AbstractState state;
  AppStore appStore = FirstInit.appStore;
  void notifyDataChanged() {
    notifyListeners();
  }
}

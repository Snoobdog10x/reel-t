
import 'package:flutter/material.dart';
import 'abstract_state.dart';

abstract class AbstractProvider extends ChangeNotifier {
  late AbstractState state;
  void notifyDataChanged() {
    notifyListeners();
  }
}

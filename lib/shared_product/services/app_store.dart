import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';
import 'package:reel_t/shared_product/services/local_user.dart';

class AppStore {
  Function? notifyDataChanged;
  LocalStorage localStorage = LocalStorage();
  LocalUser localUser = LocalUser();
  CloudStorage cloudStorage = CloudStorage();
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  void setNotify(Function notifyDataChanged) {
    this.notifyDataChanged = notifyDataChanged;
  }

  Future<void> init() async {
    await localStorage.init();
    localUser.init(localStorage);
  }

  bool isConnected() {
    if (_connectionStatus == ConnectivityResult.wifi) return true;
    return false;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    notifyDataChanged?.call();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      print("connect");
      return;
    }

    return _updateConnectionStatus(result);
  }
}

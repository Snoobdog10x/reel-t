import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:reel_t/shared_product/services/cloud_storage.dart';
import 'package:reel_t/shared_product/services/local_storage.dart';
import 'package:reel_t/shared_product/services/local_user.dart';
import 'package:reel_t/shared_product/services/security.dart';

class AppStore {
  Function? _notifyDataChanged;
  LocalStorage localStorage = LocalStorage();
  LocalUser localUser = LocalUser();
  CloudStorage cloudStorage = CloudStorage();
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  Security security = Security();
  void setNotify(Function notifyDataChanged) {
    _notifyDataChanged = notifyDataChanged;
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
    _notifyDataChanged?.call();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      return;
    }

    return _updateConnectionStatus(result);
  }
}

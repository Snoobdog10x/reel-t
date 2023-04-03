// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared_product/widgets/app_theme.dart';
import 'app_init.dart';
import 'app_store.dart';
import 'abstract_provider.dart';

abstract class AbstractState<T extends StatefulWidget> extends State<T> {
  AppStore appStore = AppInit.appStore;
  late AbstractProvider _provider;
  late BuildContext _context;
  late double _topPadding;
  late double _screenHeight;
  late double _screenWidth;
  AppTheme _theme = AppTheme();
  void onCreate();
  void onDispose();
  void onReady();
  bool hasDisplayConnected = true;
  AbstractProvider initProvider();
  BuildContext initContext();
  Widget buildScreen({
    bool isSafe = true,
    bool isSafeTop = true,
    bool isSafeBottom = true,
    bool isPushLayoutWhenShowKeyboard = false,
    bool isShowConnect = true,
    Widget? appBar,
    Widget? bottomNavBar,
    Widget? body,
    EdgeInsets? padding,
    Color background = Colors.white,
    bool isDarkTheme = true,
  }) {
    List<Widget> layout = [];
    EdgeInsets truePadding = EdgeInsets.only(
      top: isSafe && isSafeTop ? paddingTop() : 0,
      left: padding?.left ?? 0,
      right: padding?.right ?? 0,
      bottom: isSafe && isSafeBottom ? paddingBottom() : 0,
    );
    layout.add(_buildAppBar(appBar, truePadding));
    layout.add(Expanded(child: _buildTrueBody(body, truePadding)));
    if (isShowConnect) {
      if (!appStore.isConnected()) {
        layout.add(_buildConnectionStatus(false, isSafe && isSafeBottom));
        hasDisplayConnected = false;
      }

      if (hasDisplayConnected == false && appStore.isConnected()) {
        layout.add(_buildConnectionStatus(true, isSafe && isSafeBottom));
        Future.delayed(Duration(seconds: 2), () {
          hasDisplayConnected = true;
          notifyDataChanged();
        });
      }
    }
    layout.add(_buildBottomBar(bottomNavBar, truePadding));

    return Theme(
      data: isDarkTheme ? _theme.DARK_THEME : _theme.LIGHT_THEME,
      child: Scaffold(
        resizeToAvoidBottomInset: isPushLayoutWhenShowKeyboard,
        backgroundColor: background,
        body: Column(
          children: layout,
        ),
      ),
    );
  }

  Widget _buildTrueBody(Widget? body, EdgeInsets padding) {
    return Padding(
      padding: EdgeInsets.only(left: padding.left, right: padding.right),
      child: body,
    );
  }

  Widget _buildBottomBar(Widget? bottomBar, EdgeInsets padding) {
    return Container(
      padding: EdgeInsets.only(bottom: padding.bottom),
      child: bottomBar,
    );
  }

  Widget _buildAppBar(Widget? appBar, EdgeInsets padding) {
    return Container(
      padding: EdgeInsets.only(top: padding.top),
      child: appBar,
    );
  }

  Widget _buildConnectionStatus(bool isConnected, bool isSafe) {
    return Container(
      margin: EdgeInsets.only(top: isSafe ? 0 : paddingBottom()),
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      color: isConnected ? Colors.green : Colors.red,
      child: Text(isConnected ? "Connected" : "Disconnected"),
    );
  }

  @override
  void initState() {
    super.initState();
    onCreate();
    _provider = initProvider();
    _provider.state = this;
    _context = initContext();
    appStore.setNotify(notifyDataChanged);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        onReady();
      },
    );
  }

  void notifyDataChanged() {
    _provider.notifyDataChanged();
  }

  double screenHeight() {
    if (_context == null) {
      return 0;
    }
    return MediaQuery.of(_context!).size.height;
  }

  double screenWidth() {
    if (_context == null) {
      return 0;
    }
    return MediaQuery.of(_context!).size.width;
  }

  double screenRatio() {
    if (_context == null) {
      return 0;
    }
    return MediaQuery.of(_context!).size.aspectRatio;
  }

  double paddingTop() {
    if (_context == null) {
      return 0;
    }
    return MediaQuery.of(_context!).padding.top;
  }

  double paddingBottom() {
    if (_context == null) {
      return 0;
    }
    return MediaQuery.of(_context!).padding.bottom;
  }

  @override
  Widget build(BuildContext context);
  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  bool _isLoading = false;
  void stopLoading() {
    if (!_isLoading) return;
    Navigator.pop(_context);
    _isLoading = false;
  }

  void showScreenBottomSheet(Widget content, {double? height}) {
    if (height == null) {
      height = screenHeight();
    }
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: _context,
      builder: (context) {
        return Container(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: content,
          ),
        );
      },
    );
  }

  void showAlertDialog({
    String? title,
    String? content,
    Function? confirm,
    Function? cancel,
    bool isLockOutsideTap = false,
  }) {
    stopLoading();
    List<CupertinoDialogAction> actions = [];
    if (confirm != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            confirm();
            Navigator.pop(_context);
          },
          child: const Text('OK'),
        ),
      );
    }

    if (cancel != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            cancel();
            Navigator.pop(_context);
          },
          child: const Text('NO'),
        ),
      );
    }
    showCupertinoModalPopup<void>(
      context: _context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(content ?? ""),
        actions: actions,
      ),
    );
  }

  void startLoading() {
    if (_isLoading) return;

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: 20,
            color: Colors.grey,
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    _isLoading = true;
    Future.delayed(Duration(seconds: 10), () {
      if (_isLoading) {
        stopLoading();
      }
    });
  }

  void onPopWidget() {
    notifyDataChanged();
  }

  void pushToScreen(Widget screen, {bool isReplace = false}) {
    Route route = MaterialPageRoute(builder: (context) => screen);
    if (isReplace) {
      Navigator.of(_context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (_) => false,
      );
      return;
    }

    Navigator.of(_context).push(route).then(
      (value) {
        onPopWidget();
      },
    );
  }

  void popTopDisplay() {
    Navigator.pop(_context);
  }
}

import 'package:flutter/material.dart';
import 'abstract_provider.dart';

abstract class AbstractState<T extends StatefulWidget> extends State<T> {
  AbstractProvider? _provider;
  BuildContext? _context;
  late double _topPadding;
  late double _screenHeight;
  late double _screenWidth;
  void onCreate();
  AbstractProvider initProvider();
  BuildContext initContext();
  Widget buildScreen({
    bool isSafe = true,
    Widget? appBar,
    Widget? bottomNavBar,
    Widget? body,
  }) {
    List<Widget> layout = [];
    if (appBar != null) {
      layout.add(appBar);
    }
    layout.add(body ?? Container());
    if (isSafe) {
      return Scaffold(
        bottomNavigationBar: bottomNavBar,
        body: Container(
          padding: EdgeInsets.only(top: paddingTop(), bottom: paddingBottom()),
          child: Column(
            children: layout,
          ),
        ),
      );
    }
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: Container(
        child: Column(
          children: layout,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    onCreate();
    _provider = initProvider();
    _context = initContext();
  }

  void notifyDataChanged() {
    _provider?.notifyDataChanged();
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
}

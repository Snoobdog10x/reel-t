import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String? appBarTitle;
  final Widget? appBarAction;
  const DefaultAppBar({
    super.key,
    this.appBarTitle,
    this.appBarAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                appBarTitle ?? "",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: appBarAction ?? Container(),
          ),
        ],
      ),
    );
  }
}

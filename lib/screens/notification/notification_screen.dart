import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import '../notification/notification_bloc.dart';
import '../../shared_product/widgets/default_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends AbstractState<NotificationScreen> {
  late NotificationBloc bloc;
  @override
  AbstractBloc initBloc() {
    return bloc;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    bloc = NotificationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<NotificationBloc>(
          builder: (context, value, child) {
            var body = buildBody();
            return buildScreen(
              appBar: DefaultAppBar(appBarTitle: "sample appbar"),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      children: [],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

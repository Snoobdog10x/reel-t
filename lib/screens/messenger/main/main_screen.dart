import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import 'main_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen ({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends AbstractState<MainScreen> {
  late MainProvider provider;
  @override
  AbstractProvider initProvider() {
    return provider;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    provider = MainProvider();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<MainProvider>(
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
  void onDispose() {

  }
}

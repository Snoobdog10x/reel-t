import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_provider.dart';
import '../../generated/abstract_state.dart';
import 'package:reel_t/screens/search/search_provider.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends AbstractState<SearchScreen> {
  late SearchProvider provider;
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
    provider = SearchProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<SearchProvider>(
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


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/feed/feed_provider.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen ({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends AbstractState<FeedScreen> {
  late FeedProvider provider;
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
    provider = FeedProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<FeedProvider>(
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
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [

        ],
      ),
    );
  }

  @override
  void onDispose() {}
}
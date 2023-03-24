import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import 'detail_chat_screen_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class DetailChatScreenScreen extends StatefulWidget {
  const DetailChatScreenScreen ({super.key});

  @override
  State<DetailChatScreenScreen> createState() => _DetailChatScreenScreenState();
}

class _DetailChatScreenScreenState extends AbstractState<DetailChatScreenScreen> {
  late DetailChatScreenProvider provider;
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
    provider = DetailChatScreenProvider();
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
        return Consumer<DetailChatScreenProvider>(
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_provider.dart';
import '../../../generated/abstract_state.dart';
import 'detail_chat_setting_provider.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class DetailChatSettingScreen extends StatefulWidget {
  const DetailChatSettingScreen ({super.key});

  @override
  State<DetailChatSettingScreen> createState() => _DetailChatSettingScreenState();
}

class _DetailChatSettingScreenState extends AbstractState<DetailChatSettingScreen> {
  late DetailChatSettingProvider provider;
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
    provider = DetailChatSettingProvider();
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
        return Consumer<DetailChatSettingProvider>(
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

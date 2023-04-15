import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/abstract_bloc.dart';
import '../../../generated/abstract_state.dart';
import 'switch_account_setting_and_privacy_bloc.dart';
import '../../../shared_product/widgets/default_appbar.dart';

class SwitchAccountSettingAndPrivacyScreen extends StatefulWidget {
  const SwitchAccountSettingAndPrivacyScreen ({super.key});

  @override
  State<SwitchAccountSettingAndPrivacyScreen> createState() => SwitchAccountSettingAndPrivacyScreenState();
}

class SwitchAccountSettingAndPrivacyScreenState extends AbstractState<SwitchAccountSettingAndPrivacyScreen> {
  late SwitchAccountSettingAndPrivacyBloc bloc;
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
    bloc = SwitchAccountSettingAndPrivacyBloc();
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<SwitchAccountSettingAndPrivacyBloc>(
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

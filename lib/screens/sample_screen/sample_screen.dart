import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/screens/abstracts/abstract_provider.dart';
import 'package:reel_t/screens/abstracts/abstract_state.dart';
import 'package:reel_t/screens/sample_screen/sample_provider.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends AbstractState<SampleScreen> {
  late SampleProvider sampleProvider;
  @override
  AbstractProvider initProvider() {
    return sampleProvider;
  }

  @override
  BuildContext initContext() {
    return context;
  }

  @override
  void onCreate() {
    sampleProvider = SampleProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sampleProvider,
      builder: (context, child) {
        return Consumer<SampleProvider>(
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
          Text(sampleProvider.count.toString()),
          TextButton(
            onPressed: () {
              sampleProvider.onTapButton();
            },
            child: Text("count++"),
          ),
        ],
      ),
    );
  }
}

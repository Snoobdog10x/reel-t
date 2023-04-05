import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import 'package:reel_t/screens/search/search_bloc.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends AbstractState<SearchScreen> {
  late SearchBloc bloc;
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
    bloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return Consumer<SearchBloc>(
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
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                height: screenHeight(),
                width: screenWidth(),
                color: Colors.black,
              );
            },
          ),
        )
      ],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

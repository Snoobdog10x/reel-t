import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/shared_product/widgets/text_field/custom_text_field.dart';
import '../../generated/abstract_bloc.dart';
import '../../generated/abstract_state.dart';
import 'package:reel_t/screens/search/search_bloc.dart';
import 'package:reel_t/shared_product/widgets/default_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends AbstractState<SearchScreen>
    with TickerProviderStateMixin {
  late SearchBloc bloc;
  TextEditingController _searchController = TextEditingController();
  late TabController tabController;
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
    tabController = TabController(length: 2, vsync: this);
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
              appBar: buildAppBar(),
              body: body,
            );
          },
        );
      },
    );
  }

  Widget buildAppBar() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  popTopDisplay();
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            Expanded(flex: 11, child: buildSearch()),
          ],
        ),
        buildTapBar(),
      ],
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Hot girls",
          hintStyle: TextStyle(fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        // controller: widget.controller,
        cursorColor: Colors.green,
        textInputAction: TextInputAction.search,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onSubmitted: (value) {
          _searchController.text = "";
          notifyDataChanged();
        },
      ),
    );
  }

  Widget buildTapBar() {
    return Container(
      height: 30,
      child: TabBar(controller: tabController, tabs: [
        Text("Videos"),
        Text("Users"),
      ]),
    );
  }

  Widget buildBody() {
    return TabBarView(
      controller: tabController,
      children: [Text("vidoer"), Text("user")],
    );
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

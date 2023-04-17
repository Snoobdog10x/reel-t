import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_t/models/search_history/search_history.dart';
import 'package:reel_t/shared_product/utils/text/shared_text_style.dart';
import 'package:reel_t/shared_product/widgets/text_field/custom_text_field.dart';
import 'package:reel_t/shared_product/widgets/three_row_appbar.dart';
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
  bool isVideoTab = true;
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
    bloc.init();
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
    return Row(
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
          if (value.isEmpty) return;
          bloc.addSearchHistory(value);
        },
      ),
    );
  }

  Widget buildBody() {
    List<Widget> layout = [];
    layout = bloc.searchHistories.map(
      (e) {
        return buildSearchHistoryItem(e);
      },
    ).toList();
    if (bloc.searchHistories.isNotEmpty)
      layout.add(
        GestureDetector(
          onTap: () {
            bloc.clearSearch();
          },
          child: Container(
            child: Text(
              "Clear all",
              style: TextStyle(
                color: Colors.grey,
                fontSize: SharedTextStyle.SUB_TITLE_SIZE,
                fontFamily: SharedTextStyle.DEFAULT_FONT_TEXT,
                fontWeight: SharedTextStyle.SUB_TITLE_WEIGHT,
              ),
            ),
          ),
        ),
      );
    return SingleChildScrollView(
      child: Column(
        children: layout,
      ),
    );
  }

  Widget buildSearchHistoryItem(SearchHistory searchHistory) {
    return ThreeRowAppBar(
      firstWidget: Container(width: 40, child: Icon(Icons.history)),
      secondWidget: Text(
        searchHistory.searchText,
        style: TextStyle(
            color: Colors.black,
            fontSize: SharedTextStyle.SUB_TITLE_SIZE,
            fontFamily: SharedTextStyle.DEFAULT_FONT_TEXT),
      ),
      lastWidget: Container(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            bloc.removeSearchHistory(searchHistory);
          },
          child: Container(
            height: screenHeight(),
            width: 40,
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  @override
  void onPopWidget(String previousScreen) {
    super.onPopWidget(previousScreen);
  }

  @override
  void onDispose() {}

  @override
  void onReady() {
    // TODO: implement onReady
  }
}

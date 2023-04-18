import 'package:reel_t/models/search_history/search_history.dart';
import 'package:reel_t/shared_product/services/firestore_search.dart';

abstract class SearchSearchHistoryEvent {
  final _searchEngine = FirestoreSearch();
  Future<void> sendSearchSearchHistoryEvent(String searchText) async {
    try {
      var searchResult = await _searchSearchHistory(searchText);
      onSearchSearchHistoryEventDone(searchResult);
    } catch (e) {
      print(e);
      onSearchSearchHistoryEventDone([]);
    }
  }

  Future<List<SearchHistory>> _searchSearchHistory(String searchText) async {
    var searchData = await _searchEngine.searchStream(
        collectionPaths: SearchHistory.PATH,
        searchByPath: SearchHistory.searchText_PATH,
        searchText: searchText);
    return searchData.map((e) => SearchHistory.fromJson(e.data())).toList();
  }

  void onSearchSearchHistoryEventDone(List<SearchHistory> searchResult);
}

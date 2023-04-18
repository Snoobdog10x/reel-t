import 'package:reel_t/events/search/create_search_history/create_search_history_event.dart';
import 'package:reel_t/events/search/search_search_history/search_search_history_event.dart';
import 'package:reel_t/events/user/search_user/search_user_event.dart';
import 'package:reel_t/events/video/search_video/search_video_event.dart';
import 'package:reel_t/models/search_history/search_history.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/search/search_screen.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../generated/abstract_bloc.dart';

class SearchBloc extends AbstractBloc<SearchScreenState>
    with CreateSearchHistoryEvent, SearchSearchHistoryEvent {
  List<SearchHistory> searchHistories = [];
  List<SearchHistory> searchResult = [];
  void init() {
    searchHistories = appStore.localSearchHistory.getSearchHistories();
    notifyDataChanged();
  }

  Future<void> removeSearchHistory(SearchHistory searchHistory) async {
    await appStore.localSearchHistory.removeSearchHistory(searchHistory);
    searchHistories = appStore.localSearchHistory.getSearchHistories();
    notifyDataChanged();
  }

  void clearSearch() {
    state.showAlertDialog(
      title: "Clear Search History?",
      content:
          "All your search history will be deleted and it can't be recovered",
      confirmTitle: "Clear",
      cancelTitle: "Cancel",
      cancel: () {
        state.popTopDisplay();
      },
      confirm: () async {
        await appStore.localSearchHistory.clear();
        searchHistories = appStore.localSearchHistory.getSearchHistories();
        state.popTopDisplay();
        notifyDataChanged();
      },
    );
  }

  Future<void> addSearchHistory(String searchText) async {
    var newSearchHistory = SearchHistory(
      id: searchText.toLowerCase(),
      searchText: searchText.toLowerCase(),
      isLocal: true,
      createAt: FormatUtility.getMillisecondsSinceEpoch(),
    );
    await appStore.localSearchHistory.addSearchHistory(newSearchHistory);
    var cloneSearch = SearchHistory.fromJson(newSearchHistory.toJson());
    cloneSearch.isLocal = false;
    sendCreateSearchHistoryEvent(cloneSearch);
    searchHistories = appStore.localSearchHistory.getSearchHistories();
    notifyDataChanged();
  }

  @override
  void onCreateSearchHistoryEventDone(SearchHistory? newSearchHistory) {
    // TODO: implement onCreateSearchHistoryEventDone
  }

  @override
  void onSearchSearchHistoryEventDone(List<SearchHistory> searchResult) {
    this.searchResult = searchResult;
    notifyDataChanged();
  }

  List<SearchHistory> mergeLists() {
    Set<SearchHistory> searchSet = {};
    searchSet.addAll(searchHistories);
    searchSet.addAll(searchResult);
    return searchSet.toList();
  }
}

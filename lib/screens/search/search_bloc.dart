import 'package:reel_t/events/user/search_user/search_user_event.dart';
import 'package:reel_t/events/video/search_video/search_video_event.dart';
import 'package:reel_t/models/search_history/search_history.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/models/video/video.dart';
import 'package:reel_t/screens/search/search_screen.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

import '../../generated/abstract_bloc.dart';

class SearchBloc extends AbstractBloc<SearchScreenState> {
  List<SearchHistory> searchHistories = [];
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
    await appStore.localSearchHistory.addSearchHistory(
      SearchHistory(
        id: searchText,
        searchText: searchText,
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
      ),
    );
    searchHistories = appStore.localSearchHistory.getSearchHistories();
    notifyDataChanged();
  }
}

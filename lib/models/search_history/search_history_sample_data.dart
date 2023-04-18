import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/events/search/create_search_history/create_search_history_event.dart';
import 'package:reel_t/models/search_history/search_history.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

class SearchHistoryData with CreateSearchHistoryEvent {
  void initSearchHistoryData() {
    var searchText = [
      "duy",
      "thanh",
      "em xinh dep qua",
      "hot girl",
      "xinh",
      "@",
      "@duy",
      "@thng"
          "khong biet gi ghi?"
    ];
    for (var text in searchText) {
      var searchHistory = SearchHistory(
        id: text,
        searchText: text,
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
      );
      sendCreateSearchHistoryEvent(searchHistory);
    }
  }

  @override
  void onCreateSearchHistoryEventDone(SearchHistory? newSearchHistory) {
    // TODO: implement onCreateSearchHistoryEventDone
  }
}

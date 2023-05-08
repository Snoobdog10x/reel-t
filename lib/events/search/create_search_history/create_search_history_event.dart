import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/search_history/search_history.dart';

abstract class CreateSearchHistoryEvent {
  Future<void> sendCreateSearchHistoryEvent(
      SearchHistory newSearchHistory) async {
    try {
      var newSearch = await _createSearchHistory(newSearchHistory);
      onCreateSearchHistoryEventDone(newSearch);
    } catch (e) {
      print("CreateSearchHistoryEvent $e");
      onCreateSearchHistoryEventDone(null);
    }
  }

  Future<SearchHistory> _createSearchHistory(
      SearchHistory newSearchHistory) async {
    final db = FirebaseFirestore.instance.collection(SearchHistory.PATH);
    var doc = db.doc(newSearchHistory.id);
    await doc.set(newSearchHistory.toJson());
    return newSearchHistory;
  }

  void onCreateSearchHistoryEventDone(SearchHistory? newSearchHistory);
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/hash_tag/hash_tag.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';
import 'package:reel_t/shared_product/services/firestore_search.dart';

import '../../../models/video/video.dart';

abstract class SearchVideoEvent {
  FirestoreSearch _firestoreSearch = FirestoreSearch();
  Future<void> sendSearchVideoEvent(
    String searchText, {
    List<UserProfile> userProfile = const [],
  }) async {
    try {
      searchText = searchText.replaceAll("#", "");

      List<Future<List<Video>>> searchResults = [];
      searchResults.add(_searchVideoByUser(searchText, userProfile));
      searchResults.add(_searchVideoByTitle(searchText));
      searchResults.add(_searchVideoByHashtag(searchText));
      var result = _mergeVideosList(await Future.wait(searchResults));
      
      onSearchVideoEventDone(result);
    } catch (e) {
      print(e);
      onSearchVideoEventDone([]);
    }
  }

  Future<List<Video>> _searchVideoByUser(
      String searchText, List<UserProfile> userProfile) async {
    final db = FirebaseFirestore.instance.collection(Video.PATH);
    List<Future<QuerySnapshot<Map<String, dynamic>>>> searchSnapshotResults =
        [];
    userProfile.forEach((element) {
      searchSnapshotResults.add(db
          .orderBy(Video.creatorId_PATH)
          .where(Video.creatorId_PATH, isEqualTo: element.id)
          .get());
    });
    var snapshots = await Future.wait(searchSnapshotResults);

    return snapshots.map((e) => Video.fromJson(e.docs.first.data())).toList();
  }

  Future<List<Video>> _searchVideoByTitle(String searchText) async {
    var searchResult = await _firestoreSearch.searchStream(
      collectionPaths: Video.PATH,
      searchByPath: Video.title_PATH,
      searchText: searchText,
    );
    if (searchResult.isEmpty) return [];
    return searchResult.map((e) => Video.fromJson(e.data())).toList();
  }

  Future<List<Video>> _searchVideoByHashtags(List<HashTag> hashTags) async {
    List<Future<QuerySnapshot<Map<String, dynamic>>>> videoByHashtag = [];
    final db = FirebaseFirestore.instance.collection(Video.PATH);
    hashTags.forEach((hashTag) {
      var hashTagName = hashTag.hashTagName;
      videoByHashtag
          .add(db.where(Video.hashtag_PATH, arrayContains: hashTagName).get());
    });
    Set<Video> videos = {};
    (await Future.wait(videoByHashtag)).forEach((query) {
      query.docs.forEach((doc) {
        var video = Video.fromJson(doc.data());
        videos.add(video);
      });
    });
    return videos.toList();
  }

  Future<List<Video>> _searchVideoByHashtag(String searchText) async {
    var searchResult = await _firestoreSearch.searchStream(
      collectionPaths: HashTag.PATH,
      searchByPath: HashTag.id_PATH,
      searchText: searchText,
    );
    if (searchResult.isEmpty) return [];
    List<HashTag> hashTags =
        searchResult.map((e) => HashTag.fromJson(e.data())).toList();

    return await _searchVideoByHashtags(hashTags);
  }

  List<Video> _mergeVideosList(List<List<Video>> videosList) {
    Set<Video> mergedVideos = {};
    videosList.forEach((element) {
      mergedVideos.addAll(element);
    });
    return mergedVideos.toList();
  }

  void onSearchVideoEventDone(List<Video> videos);
}

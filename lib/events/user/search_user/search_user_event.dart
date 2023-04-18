import '../../../models/user_profile/user_profile.dart';
import '../../../shared_product/services/firestore_search.dart';

abstract class SearchUserEvent {
  FirestoreSearch _searchByEmail = FirestoreSearch();
  FirestoreSearch _searchByFullName = FirestoreSearch();
  FirestoreSearch _searchByUserName = FirestoreSearch();

  Future<void> sendSearchUserEvent(String searchText) async {
    try {
      List<Future<List<UserProfile>>> userProfilesListFuture = [];
      userProfilesListFuture.add(_searchUserResultsByEmail(searchText));
      userProfilesListFuture.add(_searchUserResultsByUserName(searchText));
      userProfilesListFuture.add(_searchUserResultsByFullName(searchText));
      var mergedList = _mergeLists(await Future.wait(userProfilesListFuture));
      onSearchUserEventDone(mergedList);
    } catch (e) {
      print(e);
      onSearchUserEventDone([]);
    }
  }

  Future<List<UserProfile>> _searchUserResultsByFullName(
      String searchText) async {
    var docs = await _searchByFullName.searchStream(
      collectionPaths: UserProfile.PATH,
      searchByPath: UserProfile.fullName_PATH,
      searchText: searchText,
    );
    if (docs.isEmpty) return [];
    return docs.map((e) => UserProfile.fromJson(e.data())).toList();
  }

  Future<List<UserProfile>> _searchUserResultsByUserName(
      String searchText) async {
    var docs = await _searchByUserName.searchStream(
      collectionPaths: UserProfile.PATH,
      searchByPath: UserProfile.userName_PATH,
      searchText: searchText,
    );
    if (docs.isEmpty) return [];

    return docs.map((e) => UserProfile.fromJson(e.data())).toList();
  }

  Future<List<UserProfile>> _searchUserResultsByEmail(String searchText) async {
    var docs = await _searchByEmail.searchStream(
      collectionPaths: UserProfile.PATH,
      searchByPath: UserProfile.email_PATH,
      searchText: searchText,
    );
    if (docs.isEmpty) return [];

    return docs.map((e) => UserProfile.fromJson(e.data())).toList();
  }

  List<UserProfile> _mergeLists(List<List<UserProfile>> userProfilesList) {
    Set<UserProfile> fillDuplicateUsers = {};
    userProfilesList.forEach((element) {
      fillDuplicateUsers.addAll(element);
    });

    return fillDuplicateUsers.toList();
  }

  void onSearchUserEventDone(List<UserProfile> userProfiles);
}

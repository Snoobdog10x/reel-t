import '../../models/follow/follow.dart';
import '../../generated/abstract_model.dart';
import '../../generated/abstract_repository.dart';

class FollowFirebaseRepository extends AbstractRepository<Follow> {
  @override
  Future<void> save(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return;
    return await ref.set(models.last.toJson());
  }

  @override
  Future<Follow?> find(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return null;

    var snapshot = await ref.get();
    if (!snapshot.exists) return null;

    return Follow.fromJson(snapshot.data()!);
  }

  @override
  Future<bool> delete(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return false;
    var snapshot = await ref.delete();
    return true;
  }

  @override
  void recordStreaming(void Function(Follow changedData) changedCallBack,
      List<AbstractModel> models) {
    var ref = getDocRef(models);
    if (ref == null) return;
    ref.snapshots().listen((event) {
      if (event.exists) return;
      changedCallBack(Follow.fromJson(event.data()!));
    });
  }

  @override
  void recordsStreaming(void Function(List<Follow> changedData) changedCallBack,
      int limit, List<AbstractModel> models) {
    var ref = getDocRef(models);
    if (ref == null) return;
    ref.parent.snapshots().listen((event) {
      var changedData = [
        for (var doc in event.docs) Follow.fromJson(doc.data())
      ];
      changedCallBack(changedData);
    });
  }
}

import '../../models/conversation/conversation.dart';
import '../../generated/abstract_model.dart';
import '../../generated/abstract_repository.dart';

class ConversationFirebaseRepository extends AbstractRepository<Conversation> {
  @override
  Future<void> save(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return;
    return await ref.set(models.last.toJson());
  }

  @override
  Future<Conversation?> find(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return null;

    var snapshot = await ref.get();
    if (!snapshot.exists) return null;

    return Conversation.fromJson(snapshot.data()!);
  }

  @override
  Future<bool> delete(List<AbstractModel> models) async {
    var ref = getDocRef(models);
    if (ref == null) return false;
    var snapshot = await ref.delete();
    return true;
  }

  @override
  void recordStreaming(void Function(Conversation changedData) changedCallBack,
      List<AbstractModel> models) {
    var ref = getDocRef(models);
    if (ref == null) return;
    ref.snapshots().listen((event) {
      if (event.exists) return;
      changedCallBack(Conversation.fromJson(event.data()!));
    });
  }

  @override
  void recordsStreaming(void Function(List<Conversation> changedData) changedCallBack,
      int limit, List<AbstractModel> models) {
    var ref = getDocRef(models);
    if (ref == null) return;
    ref.parent.snapshots().listen((event) {
      var changedData = [
        for (var doc in event.docs) Conversation.fromJson(doc.data())
      ];
      changedCallBack(changedData);
    });
  }
}

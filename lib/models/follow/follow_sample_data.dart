import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/follow/follow.dart';
import 'package:reel_t/shared_product/utils/format/format_utlity.dart';

class FollowData {
  Future<void> initFollowData() async {
    List<Future> awaitData = [];
    final db = FirebaseFirestore.instance.collection(Follow.PATH);
    for (int i = 0; i < 10; i++) {
      var follow = Follow(
        id: i.toString(),
        userId: i.toString(),
        followerId: 'Pg8GacuZI2aqJRXLBDmXXZqGVwo1',
        isFollow: true,
        createAt: FormatUtility.getMillisecondsSinceEpoch(),
      );
      awaitData.add(db.doc(i.toString()).set(follow.toJson()));
    }
    var docId = db.doc().id;
    awaitData.add(
      db.doc("9cCvyxZ5vHMk0dCKWX5i").set(
            Follow(
              id: "9cCvyxZ5vHMk0dCKWX5i",
              userId: "lSScQqjmqJVt9pVC8nHknMjsMIE2",
              followerId: 'Pg8GacuZI2aqJRXLBDmXXZqGVwo1',
              isFollow: true,
              createAt: FormatUtility.getMillisecondsSinceEpoch(),
            ).toJson(),
          ),
    );
    awaitData.add(db.doc("10").set(
          Follow(
            id: "10",
            userId: "Pg8GacuZI2aqJRXLBDmXXZqGVwo1",
            followerId: 'Pg8GacuZI2aqJRXLBDmXXZqGVwo1',
            isFollow: true,
            createAt: FormatUtility.getMillisecondsSinceEpoch(),
          ).toJson(),
        ));
  }
}

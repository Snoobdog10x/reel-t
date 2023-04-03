import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_t/models/user_profile/user_profile.dart';

class UserProfileData {
  Future<void> initUserProfileData() async {
    List<String> emails = [
      "wiley.boyle@brekke.com",
      "davis.janie@yahoo.com",
      "cayla.spinka@gmail.com",
      "ratke.tillman@mitchell.com",
      "tiffany.stamm@dicki.com",
      "gaetano.hirthe@parker.com",
      "muhammad.zulauf@hotmail.com",
      "schmeler.enrico@brakus.com",
      "mavis41@gmail.com",
      "miller.shad@yahoo.com",
    ];
    List<String> avatars = [
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_1.jpg?alt=media&token=cec98024-1775-48a5-9740-63d79d441842",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_10.jpg?alt=media&token=d63b5e8e-911b-478b-9225-8a2c9d72b055",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_11.jpg?alt=media&token=5db59cf7-fa6c-4952-b669-b4f4888f90a4",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_12.jpg?alt=media&token=d5efce7c-2e03-4647-a8b1-484422a3c338",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_13.jpg?alt=media&token=df8acd83-52b2-4f52-929a-189d894b1e88",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_14.jpg?alt=media&token=a46f56f3-bc5a-4b43-a6c6-966205905550",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_15.jpg?alt=media&token=7adb136e-6c17-4188-8046-c74c1fdc2e2c",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_16.jpg?alt=media&token=bd6a32c7-f5d0-47af-a9bc-c337764d5ecb",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_17.jpg?alt=media&token=3c64f876-e236-4ffd-bd8d-0f8f5cbd9243",
      "https://firebasestorage.googleapis.com/v0/b/reel-t-6b2ba.appspot.com/o/images%2F02062023_image_Beauty_18.jpg?alt=media&token=18603e86-d15b-4d65-807e-d1eaff1fe312",
    ];
    List<String> bios = [
      "1f you c4n r34d 7h15, you r34lly n33d 2 g37 l41d.",
      "A bus station is where a bus stops. A train station is where a train stops. On my desk, I have a work station.",
      "A lie is just a great story ruined by truth.",
      "Actually, I’m not funny, I’m having a mental disorder",
      "Alzheimer’s can’t be that bad. You get to meet new people every day.",
      "Atheism is a non-prophet organization.",
      "BAE: Bacon And Eggs.",
      "Born at a very young age.",
      "Cartoonist found dead in his home. Details are sketchy.",
      "Chaos, panic & disorder – my work here is done.",
    ];
    final _random = new Random();
    for (var email in emails) {
      var index = emails.indexOf(email);
      var userName = email.split("@")[0];
      var bio = bios[index];
      var ava = avatars[index];
      var userProfile = UserProfile(
        id: index.toString(),
        userName: userName,
        email: email,
        fullName: "Clone Account ${index}",
        avatar: ava,
        bio: bio,
        numFollower: _random.nextInt(200000),
        numFollowing: _random.nextInt(200000),
        createAt: Timestamp.now().millisecondsSinceEpoch,
      );
      final db = FirebaseFirestore.instance;
      db
          .collection(UserProfile.PATH)
          .doc(index.toString())
          .set(userProfile.toJson());
    }
  }
}

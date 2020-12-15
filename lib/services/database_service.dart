import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userProfilesCollection = FirebaseFirestore.instance.collection("user_profiles");

  Future setUserProfileData(String username) async {
    return await userProfilesCollection.doc(uid).set({
      "username": username,
      "bio": "",
      "posts" : 0,
      "followers" : 0,
      "following" : 0,
    });
  }
  Future updateUserProfileData(String username, String bio) async {
    return await userProfilesCollection.doc(uid).update({
      "username" : username,
      "bio" : bio,
    });
  }

  Future updateUserSocalData(String followers, String following) async {
    return await userProfilesCollection.doc(uid).update({
      "followers" : int.parse(followers),
      "following" : int.parse(following),
    });
  }

  Stream<DocumentSnapshot> get personalUserData {
    return userProfilesCollection.doc(uid).snapshots();
  }
}